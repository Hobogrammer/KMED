require_relative 'constants'

class Gaiji
  include Constants

  def initialize(dictionary_name)
    @set = dictionary_name
    @gaiji = _set_hash
  end

  def convert(code)
    code = _get_code(code)
    @gaiji["#{code}"]	
  end

  def _get_code(gaiji)
    code = gaiji.match(/w.*[^(\])]/)
    code = code.to_s

    code.sub('w', '0x')
  end

  def _set_hash
    Constants.const_get(@set)
  end
end
