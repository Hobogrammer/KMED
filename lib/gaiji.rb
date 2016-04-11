class Gaiji
  include Constants

  def initialize()

  end

  def convert(gaiji)
	
  end

  def _get_code(gaiji)
    code = gaiji.match(/w.*[^(\])]/)
    code = code.to_s

    code.sub('w', '0x')
  end

  def _set_hash
	
  end
end
