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

class Dictionary
attr_reader :name

  def initialize(filepath)
    @dic = _set_dic(filepath)
    @hook = DefaultHook.new(@dic)
    @name = @dic.getName 
  end

  def _set_dic(filepath)
    dic = Book.new(filepath).getSubBooks.first
  end

  def search(key)
    searcher = @dic.searchWord(key)
    result = searcher.getNextResult
    definition = result.getText(@hook) if result
  end
end
