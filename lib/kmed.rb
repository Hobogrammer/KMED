require 'csv'
require 'logger'
require_relative 'dictionary'
require_relative 'gaiji'
require_relative 'import'


def main
  dic_path = ARGV[0]
  kindle_export_path = ARGV[1]
  timestamp = Time.now.strftime("%Y%m%d%H%M%S")

  file_name = "ankiImport_#{timestamp}"
  out_path = "./output/#{file_name}.txt"
  puts "Exporting to: #{out_path}"


  logger = Logger.new("#{file_name}.log"
  dic = Dictionary.new(dic_path)
  gaiji = Gaiji.new(dic.name.upcase)
  line_count = 0
  CSV.open(out_path, "w") do |csv|
    import = ImportHandler.new
    File.foreach(kindle_export_path) do |line|
      begin
        line = line.strip
      rescue
        puts "Strip failed on line from export: #{line}"
        next
      end

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
      definition = dic.search(import.term)
      import.set_definition(gaiji, definition)
      csv << [import.term,import.term_w_furi,import.definition,import.sentence,
              [import.title, import.author, import.publisher].join(' ')]
      line_count += 1
    end
  end
end

main()
