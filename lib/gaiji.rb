require_relative 'constants'

class Gaiji
  include Constants

  def initialize(dictionary_name)
    @gaiji = set_dictionary_const(dictionary_name)
  end

  def de_gaiji(definition)
    return if definition.nil?
    gaiji_a = definition.scan(/\[.*?\]/)
    if !gaiji_a.empty?
      gaiji_a.each do |gaiji|
        convert(gaiji) ? definition = definition.gsub("#{gaiji}", convert(gaiji)) : definition = definition.gsub("#{gaiji}", '')
      end
    end
    definition
  end

  private

  def convert(code)
    code = get_code(code)
    @gaiji["#{code}"]	
  end

  def get_code(gaiji)
    code = gaiji.match(/w.*[^(\])]/)
    code = code.to_s

    code.sub('w', '0x')
  end

  def set_dictionary_const(dictionary_name)
    Constants.const_get(dictionary_name)
  end
end
