Dir[Rails.root.join("db", "seeds", "*.rb")].sort.each do |seed_file|
  load seed_file
end

puts "Seeds loaded"
