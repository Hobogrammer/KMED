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

book_path = File.open("resource/JMdict")
book = Book.new(book_path.path)

search_term = "油"
sub_dic = book.getSubBooks
dic = sub_dic[0]
searcher = dic.searchWord(search_term)
hook = DefaultHook.new(dic)

while (searcher.getNextResult)
  result = searcher.getNextResult
  puts result.getText(hook)
end