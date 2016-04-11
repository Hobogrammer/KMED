
Dir["./resource/gaiji_table/*.c"].each do |gtable|
  puts "File path: #{gtable}"
  
  table_name = File.basename(gtable).gsub('.c', '.txt')
  puts "Opening file #{table_name}"
  table_file = File.new(table_name, "w")
 
  File.foreach("#{gtable}") do |line|
    hex_pattern = /(0x.{4})/
    char_pattern = /\/\*.?(.).*\*\//

    code = line.scan(hex_pattern).flatten.first
    if code
      char = line.scan(char_pattern).flatten.first.to_s
      table_file.puts "\"#{code}\" => \"#{char}\","
    end
  end
  table_file.close
end
