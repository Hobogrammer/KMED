require 'csv'
require 'java'
require './jars/eb4j-core-1.0.5.jar'
require './jars/commons-collections-3.2.1.jar'
require './jars/commons-cli-1.2.jar'
require './jars/commons-io-1.4.jar'
require './jars/commons-lang-2.4.jar'
require './jars/conv-wdic-1.0.5.jar'
require './jars/conv-zipcode-1.0.5.jar'
require './jars/eb4j-tools-1.0.5.jar'
require './jars/log4j-1.2.14.jar'
require './jars/slf4j-api-1.5.10.jar'
require './jars/slf4j-log4j12-1.5.10.jar'
require './jars/xml2eb-1.0.5.jar'

java_import 'fuku.eb4j.Book'
java_import 'fuku.eb4j.hook.DefaultHook'

def unarray(deep_array)
  puts "INSPECT ARRAY: #{deep_array}"
  deep_array.empty? ? deep_array : deep_array[0].join(' ')
end

timestamp = Time.now.strftime("%Y%m%d%H%M%S")
book_file = File.open("resource/JMdict")
book = Book.new(book_file.path)
book_file.close
sub_dic = book.getSubBooks
dic = sub_dic[0]
hook = DefaultHook.new(dic)

CSV.open("./resource/#{timestamp}_ankiImport.csv", "w") do |csv|
  File.foreach("./resource/kindleExportTest.txt") do |line|
    parts = line.scan(/^(\S*)[\s](\S*)/)
    term = parts[0][0].gsub(/(\(.*?\))/, '')
    definition = String.new

    if !term.empty?
      searcher = dic.searchWord(term)
      result = searcher.getNextResult
      definition = result.getText(hook) if result
    end
      
    puts "Captured Term: #{term}"
    puts "Searched Definition: #{definition}"
    puts "Unfiltered line: #{parts}"
    parts = unarray(parts)
    puts "Whole line: #{parts}"
    furi = parts.scan(/(\(.*?\))/)
    furi = unarray(furi)
    puts "Captured furigana: #{furi}"
    furi.empty? ? (puts "No Furi") : pure_furi = furi.gsub(/\(|\)/, '')
    puts "Pure Furi: #{pure_furi}"
    csv << ["#{term}","#{furi}","#{definition}","#{parts}"]
  end
end
