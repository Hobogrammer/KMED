require 'csv'
require_relative 'dictionary'
require_relative 'gaiji'


def main
  dic_path = ARGV[0]
  kindle_export_path = ARGV[1]

  timestamp = Time.now.strftime("%Y%m%d%H%M%S")

  dic = Dictionary.new(dic_path)
  gaiji = Gaiji.new(dic.name.upcase)
  CSV.open("./resource/#{timestamp}_ankiImport.csv", "w") do |csv|
    File.foreach(kindle_export_path) do |line|
      term_w_furi, sentence = line.match(/^(\S*)[\s](\S*)/).captures
      term = term_w_furi.gsub(/(\(.*?\))/, '')
      definition = dic.search(term)

      definition = gaiji.de_gaiji(definition)
      csv << ["#{term}","#{term_w_furi}","#{definition}","#{sentence}"]
    end
  end
end

main()
