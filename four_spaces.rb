#!/usr/bin/env ruby

Dir.glob("**/**/*.{rb}") do |file|
    text = File.read(file)
    new_contents = text.gsub(/    /, "        ")
    File.open(file, "w") {|f| f.puts new_contents }
end
