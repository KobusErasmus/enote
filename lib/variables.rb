@green = "\033[0;32m"
@red = "\033[0;31m"
@white = "\033[0m"

@enote_dir = "#{Dir.home}/.enote"
@conf_file = "#{@enote_dir}/enote_config"
@conf = YAML.load_file(@conf_file)
@notes_dir = @conf["notes_dir"]
@default_editor = @conf["editor"]
@tags = (@conf["tags"] ||= {})
@arguments =[]
