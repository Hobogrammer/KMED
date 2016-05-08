module ImportHandler
  
  def self.to_hash(import)
    import = import.gsub(/^\d\)\s?/, '')
    metadata = _get_meta(import.match(/《.*?》/).to_s)
    sentence = import.gsub(/《.*?》/, '')
    {:sentence => sentence, :meta_string => metadata}
  end

  def self._get_title(import)
    import.match(/^《(.\S*)/).to_s.gsub("《", '')
  end

  def self._get_meta(meta)
    title = _get_title(meta)
    publisher , author = meta.scan(/\((.*?)\)/).flatten
    [title, author, publisher].join(",")
  end

  def self.defuri(full_term)
    full_term.gsub(/(\(.*?\))/, '')
  end
end
