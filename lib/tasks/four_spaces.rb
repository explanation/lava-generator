namespace :custom do
	task :convert_spaces do
		puts "Converts 2 spaces into 4 spaces"
		Dir.glob("**/**/*.{rb}") do |file|
			text = File.read(file)
			new_contents = text.gsub(/	/, "		")
			File.open(file, "w") { |f| f.puts new_contents }
		end
	end
end
