require 'csv'

def unarray(deep_array)
  puts "INSPECT ARRAY: #{deep_array}"
  deep_array.empty? ? deep_array : deep_array[0].join(' ')
end

CSV.open("./resource/ankiImport.csv", "w") do |csv|
  File.foreach("./resource/kindleExportTest.txt") do |line|
    parts = line.scan(/^(\S*)[\s](\S*)/)
    term = parts[0][0].gsub(/(\(.*?\))/, '')
    puts "Captured Term: #{term}"
    puts "Unfiltered line: #{parts}"
    parts = unarray(parts)
    puts "Whole line: #{parts}"
    furi = parts.scan(/(\(.*?\))/)
    furi = unarray(furi)
    puts "Captured furigana: #{furi}"
    furi.empty? ? (puts "No furi") : pure_furi = furi.gsub(/\(|\)/, '')
    puts "Pure Furi: #{pure_furi}"
    csv << ["#{term}", "#{furi}", "#{parts}", ""]
  end
end
