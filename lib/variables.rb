@green = "\033[0;32m"
@red = "\033[0;31m"
@white = "\033[0m"
@dir = "#{Dir.home}/.enote"
@notes_dir = "#{@dir}/notes"
@conf = "#{@dir}/config"
@default_editor = File.read(@conf)[/(?<=editor=)(.*)/]
