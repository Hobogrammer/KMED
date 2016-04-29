require 'csv'
require_relative 'dictionary'
require_relative 'gaiji'


def main
  dic_path = ARGV[0]
  kindle_export_path = ARGV[1]

  timestamp = Time.now.strftime("%Y%m%d%H%M%S")

  puts "Dictionary File: #{dic_path}"
  puts "Kindle export path: #{kindle_export_path}"

  dic = Dictionary.new(dic_path)
  CSV.open("./resource/#{timestamp}_ankiImport.csv", "w") do |csv|
    File.foreach(kindle_export_path) do |line|
      term_w_furi, sentence = line.match(/^(\S*)[\s](\S*)/).captures
      term = term_w_furi.gsub(/(\(.*?\))/, '')
      definition = dic.search(term)

      
      puts "Captured Term: #{term}"
      puts "Searched Definition: #{definition}"
      puts "Sentence: #{sentence}"
      csv << ["#{term}","#{term_w_furi}","#{definition}","#{sentence}"]
    end
  end
end

main()
