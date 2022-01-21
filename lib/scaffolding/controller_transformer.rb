class Scaffolding::ControllerTransformer < Scaffolding::Transformer
  def add_option_to_account_load_and_authorize_resource option_hash
    transformed_file_name = transform_string("./app/controllers/account/scaffolding/completely_concrete/tangible_things_controller.rb")
    transformed_needle = transform_string("account_load_and_authorize_resource :scaffolding_completely_concrete_tangible_thing")

    begin
      target_file_content = File.read(transformed_file_name)
    rescue Errno::ENOENT => _
      puts "Couldn't find '#{transformed_file_name}'".red unless suppress_could_not_find
      return false
    end
    key = option_hash.keys.first
    value = option_hash.values.first

    new_target_file_content = []

    line_found = false
    target_file_content.split("\n").each do |line|
      if line.match?(/#{transformed_needle}/)
        line_found = true
        # check if the option_hash key already exists
        if line.match?(/#{key}:\s+\[/)
          current_values = line.match(/#{key}: \[([^\]]*)/)[1].split(":").map(&:squish).reject(&:blank?).map(&:to_sym)
          return true if current_values.include?(value.to_sym)
          key_index = line.index(/#{key}:\s+\[[^\]]*/)
          key_length = line.match(/#{key}:\s+\[[^\]]*/).to_s.length
          line.insert(key_index + key_length, ", :#{value}")
        else
          last_non_whitespace_character = line.index(/\s*$/)
          line.insert(last_non_whitespace_character, ", #{key}: [:#{value}]")
        end
      end
      new_target_file_content << line
    end
    File.write(transformed_file_name, new_target_file_content.join("\n").strip + "\n") if line_found
  end
end
