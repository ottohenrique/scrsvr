# clear screen
puts "\e[H\e[2J"

begin
  # output content from file
  File.open 'source_sample.rb' do |src|
    src.lines.each do |line|
      puts line
      sleep 0.2
    end
  end
rescue Interrupt => e # don't send ctrl c exception to terminal
  puts "\e[H\e[2J"
end
