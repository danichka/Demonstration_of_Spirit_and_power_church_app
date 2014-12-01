module SassConverter
  module_function

  # TODO: execute expressions such as $new_var: $old_var + $some_other_var.

  def convert(file_path="#{Rails.root}/app/assets/stylesheets/variables.css.scss")
    Rails.cache.fetch([file_path, File.mtime(file_path)]) do
      variables_list = read_variables(file_path)
      variables_to_h(variables_list)
    end
  end

  private

  def self.read_variables(file_path)
    variables_list = []

    File.readlines(file_path).each do |line|
      variables_list << line
    end

    variables_list
  end

  def self.variables_to_h(variables_list)
    sass_hash = {}
    variables_list.each do |line|
      regexp_result = line.scan(/\$(.+):(\s*)(.+);/).flatten                                       #$ any_symbols : any_space_symbols actual_value ;

      if regexp_result.any?
        var_name  = regexp_result[0]                                                                # First regexp group.
        var_value = destringify(regexp_result[2])                                                   # Third regexp group.

        sass_hash[var_name.to_sym] = var_value
      end
    end

    Rails.logger.info "SassConverter: values converted: #{sass_hash}"

    sass_hash
  end

  def self.destringify(value)
    if int?(value)
      value.to_i
    elsif float?(value)
      value.to_f
    else
      value
    end
  end

  def self.int?(str)
    str.to_i.to_s == str
  end

  def self.float?(str)
    !!Float(str) rescue false
  end
end