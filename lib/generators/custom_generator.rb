class CustomGenerator < Rails::Generators::Base
  def run_after_generate
    Rake::Task['custom:convert_spaces'].invoke
  end
end
