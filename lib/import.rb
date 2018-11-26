# -*- encoding : utf-8 -*-
require 'fuzzystringmatch'
require 'natto'

class ImportHandler
  attr_reader :author, :definition, :publisher, :sentence,
    :term, :term_w_furi, :title

  def initialize(logger)
    @author = ""
    @definition = ""
    @publisher = ""
    @sentence = ""
    @term = ""
    @term_w_furi = ""
    @title = ""
    @logger = logger
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
    @metadata = set_meta(import.match(/\<.*?\>$/).to_s)
    @sentence = import.gsub(/\<.*?\>$/, '').strip!
    post_process()
  end

  private

  def get_title(import)
    import.match(/^\<.*?\</).to_s.gsub("<", '').gsub(">",'')
  end

  def set_meta(meta)
    @title = get_title(meta)
    meta.gsub!(/\<.*?\>/,'')
    @publisher , @author = meta.scan(/\((.*?)\)/).flatten
  end

  def defuri(full_term)
    full_term.gsub(/(\(.*?\))/, '')
  end

  def post_process()
    return if term.empty?
    natto = Natto::MeCab.new('-F%f[0],%f[6],%f[7]')
    fuzzy = FuzzyStringMatch::JaroWinkler.create(:pure)
    conjugated_term = ""
    term_match = false

    parse_enum = natto.enum_parse(@sentence)

    @logger.debug('----------------------------------------------------------')
    @logger.debug("Current Sentence: #{@sentence}")
    @logger.debug("Current TERM: #{@term}")

    begin
      parse_enum.each do |x|
        @logger.debug("Surface: #{x.surface}")
        @logger.debug("Features: #{x.feature}")
        @logger.debug("Current conjugated_term: #{conjugated_term}")
        @logger.debug("Surface Match term? #{x.surface == @term}")

        if term_match == false
          root = x.feature.split(',')[1]

          @logger.debug("Term match root? #{root == @term}")
          @logger.debug("Term distance to root #{fuzzy.getDistance(@term, root)}")
          @logger.debug('----------------------------------------------------------')

          if x.surface == @term
            conjugated_term += x.surface
            term_match = true
            break
          elsif (fuzzy.getDistance(@term, root) > 0.89)
            conjugated_term += x.surface
            term_match = true
          end
        else
          part_of_speech, root, reading = x.feature.split(',')
          conjugated_term += x.surface if part_of_speech == "助動詞" || x.surface = 'て'
          break
        end
      end
    rescue
      @logger.debug("Natto broke. Falling back")
    end

    @logger.debug("Sentence before: #{@sentence}")
    colors = ["#A6E22E", "#947ABE"]
    if !conjugated_term.empty?
      @logger.debug("MATCHED CONJUGATED_TERM: #{conjugated_term}")
      @sentence = sentence.gsub(conjugated_term, "<span style='color:#{colors.sample}'>#{conjugated_term}</span>")
    else
      @logger.debug("NO MATCHES FOUND")
      @sentence = sentence.gsub(@term, "<span style='color:#{colors.sample}'>#{@term}</span>")
    end
    @logger.debug("Result: #{@sentence}")
  end
end
