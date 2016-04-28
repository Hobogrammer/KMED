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
      parts = line.scan(/^(\S*)[\s](\S*)/)
      term = parts[0][0].gsub(/(\(.*?\))/, '')
      definition = dic.search(term)

      
      puts "Captured Term: #{term}"
      puts "Searched Definition: #{definition}"
      puts "Unfiltered line: #{parts}"
      parts = parts.flatten.join(' ') #seperate the desentence and furigana before this for easier processing
      puts "PARTS AFTER FLATTEN: #{parts}"
      puts "Whole line: #{parts}"
      furi = parts.scan(/(\(.*?\))/)
      furi = furi.flatten.join(' ')
      puts "Captured furigana: #{furi}"
      furi.empty? ? (puts "No Furi") : pure_furi = furi.gsub(/\(|\)/, '')
      puts "Pure Furi: #{pure_furi}"
      csv << ["#{term}","#{furi}","#{definition}","#{parts}"]
    end
  end
end

main()
