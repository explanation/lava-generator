desc "Convert tabs to spaces in all Ruby files"
task fix_indentation: :environment do
  # Find all Ruby files in the directory and its subdirectories
  files = Dir.glob("#{Rails.root}/**/*.rb")

  spaces_per_tab = 2


  files.each do |file|
    next unless File.file?(file)

    # Read the contents of the file
    content = File.read(file)

    # Replace all leading spaces with tabs
    content.gsub!(/ {#{spaces_per_tab}}/, "\t")


    # Write the modified content back to the file
    File.write(file, content)
  end



  # Display a message when the task completes
  puts "🎉 Indentation completed successfully! 🎉"
end
