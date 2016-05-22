require_relative 'constants'

class Gaiji
  include Constants

  def initialize(dictionary_name)
    @gaiji = _set_hash(dictionary_name)
  end

  def de_gaiji(definition)
    return if definition.nil?
    gaiji_a = definition.scan(/\[.*?\]/)
    if !gaiji_a.empty?
      gaiji_a.each do |gaiji|
        _convert(gaiji) ? definition = definition.gsub("#{gaiji}", _convert(gaiji)) : definition = definition.gsub("#{gaiji}", '')
      end
    end
    definition
  end

  def _convert(code)
    code = _get_code(code)
    @gaiji["#{code}"]	
  end

  def _get_code(gaiji)
    code = gaiji.match(/w.*[^(\])]/)
    code = code.to_s

    code.sub('w', '0x')
  end

  def _set_hash(dictionary_name)
    Constants.const_get(dictionary_name)
  end
end
