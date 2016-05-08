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
    term , term_w_furi = ""
    File.foreach(kindle_export_path) do |line|
      if (line == "\r\n" || line == "\n" || line.empty?)
        line_count = 0
        next
      end

      if line_count.zero?
        term_w_furi = line
        term = ImportHandler.defuri(term_w_furi)
        line_count += 1
        next
      end

      import = ImportHandler.to_hash(line)
      definition = dic.search(term)
      definition = gaiji.de_gaiji(definition)
      csv << [term,term_w_furi,definition,import[:sentence],import[:meta_string]]
      line_count += 1
    end
  end
end

main()
