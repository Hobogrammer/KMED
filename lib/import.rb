require 'fuzzystringmatch'
require 'natto'

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

  #TODO: add ruby logger
  def post_process()
    natto = Natto::MeCab.new('-F%f[0],%f[6],%f[7]')
    fuzzy = FuzzyStringMatch::JaroWinkler.create(:pure)
    conjugated_term = ""
    term_match = false

    parse_enum = natto.enum_parse(@sentence)
    
    puts '----------------------------------------------------------'
    puts "Current Sentence: #{@sentence}"
    puts "Current TERM: #{@term}"

    begin
      parse_enum.each do |x|
        puts "Surface: #{x.surface}"
        puts "Features: #{x.feature}"
        puts "Current conjugated_term: #{conjugated_term}"
        puts "Surface Match term? #{x.surface == @term}"
        if term_match == false
          root = x.feature.split(',')[1]

          puts "Term match root? #{root == @term}"
          puts "Term distance to root #{fuzzy.getDistance(@term, root)}"
          puts '----------------------------------------------------------'

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
      puts "Natto broke. Falling back"
    end

    puts "Sentence before: #{@sentence}"
    colors = ["#A6E22E", "#947ABE"]
    if !conjugated_term.empty?
      puts "MATCHED CONJUGATED_TERM: #{conjugated_term}"
      @sentence = sentence.gsub(conjugated_term, "<span style='color:#{colors.sample}'>#{conjugated_term}</span>")
    else
      puts "NO MATCHES FOUND"
      @sentence = sentence.gsub(@term, "<span style='color:#{colors.sample}'>#{@term}</span>")
    end
    puts @sentence
  end
end
