class ImportHandler
attr_reader :author, :definition, :publisher, :sentence,
  :term, :term_w_furi, :title

  def initialize()
    @author = ""
    @definition = ""
    @publisher = ""
    @sentence = ""
    @term = ""
    @term_w_furi = ""
    @title = ""
  end

  def set_definition(definition)
    @definition = definition
  end

  def set_term(import)
    @term_w_furi = import
    @term = _defuri(@term_w_furi)
  end

  def process_sentence_meta(import)
    import = import.gsub(/^\d\)\s?/, '')
    @metadata = _set_meta(import.match(/《.*?》/).to_s)
    @sentence = import.gsub(/《.*?》/, '')
    _post_process()
  end

  def _get_title(import)
    import.match(/^《(.\S*)/).to_s.gsub("《", '')
  end

  def _set_meta(meta)
    @title = _get_title(meta)
    @publisher , @author = meta.scan(/\((.*?)\)/).flatten
  end

  def _defuri(full_term)
    full_term.gsub(/(\(.*?\))/, '')
  end

  def _post_process()
    colors = ["#A6E22E", "#947ABE"]
    @sentence = sentence.gsub(@term, "<span style='color:#{colors.sample}'>#{@term}</span>")
  end
end
