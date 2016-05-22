require 'csv'
require_relative 'dictionary'
require_relative 'gaiji'
require_relative 'import'


def main
  dic_path = ARGV[0]
  kindle_export_path = ARGV[1]
  timestamp = Time.now.strftime("%Y%m%d%H%M%S")
  out_path = "ankiImport_#{timestamp}.txt"


  dic = Dictionary.new(dic_path)
  gaiji = Gaiji.new(dic.name.upcase)
  line_count = 0
  CSV.open(out_path, "w") do |csv|
    import = ImportHandler.new
    File.foreach(kindle_export_path) do |line|
      line = line.strip

      if line.empty?
        line_count = 0
        next
      end

      if line_count.zero?
        import.set_term(line)
        line_count += 1
        next
      end

      import.process_sentence_meta(line)
      import.set_definition(gaiji.de_gaiji(dic.search(import.term)))
      csv << [import.term,import.term_w_furi,import.definition,
              import.sentence,"#{import.title}, #{import.author},
              #{import.publisher}"]
      line_count += 1
    end
  end
end

main()
