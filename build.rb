
puts 'Building...'
(1...100).each do |x|
  puts "#{x}%"
  sleep 0.1
end
puts `git log --all --oneline --graph`
puts 'Done!'