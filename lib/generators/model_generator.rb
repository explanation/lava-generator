class ModelGenerator < Rails::Generators::NamedBase
    source_root Rails::Generators::ModelGenerator.source_root

    def fix_indentation
        gsub_file 'app/models/'+file_name+'.rb', /  /, "    "
    end
end
