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


Dir.entries("./resource/dics").reject{ |dir| dir.match(/\./) }.each do |dic_dir|
  book = Book.new("./resource/dics/#{dic_dir}/")
  sub_dic = book.getSubBooks
  sub_dic = sub_dic.first
  puts sub_dic.getName
end
