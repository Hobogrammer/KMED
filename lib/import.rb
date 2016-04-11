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

  def set_definition(gaiji, definition)
    @definition = gaiji.de_gaiji(definition)
  end

  def set_term(import)
    @term_w_furi = import
    @term = defuri(@term_w_furi)
  end

  def process_sentence_meta(import)
    import = import.gsub(/^\d\)\s?/, '')
    @metadata = set_meta(import.match(/《.*?》/).to_s)
    @sentence = import.gsub(/《.*?》/, '')
    post_process()
  end

  private

  def get_title(import)
    import.match(/^《(.\S*)/).to_s.gsub("《", '')
  end

  def set_meta(meta)
    @title = get_title(meta)
    @publisher , @author = meta.scan(/\((.*?)\)/).flatten
  end

  def defuri(full_term)
    full_term.gsub(/(\(.*?\))/, '')
  end

  def post_process()
    colors = ["#A6E22E", "#947ABE"]
    @sentence = sentence.gsub(@term, "<span style='color:#{colors.sample}'>#{@term}</span>")
  end
end
