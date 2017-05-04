def has_notes
   !Dir["#{@notes_dir}/*"].entries.empty?
end

def list
  if has_notes
    system("ls #{@notes_dir}")
  else
    puts "No notes created yet"
  end
end

def edit(name)
  cmd = "#{@default_editor} #{@notes_dir}/#{name}"
  system(cmd)
  unless $CHILD_STATUS.exitstatus == 0
    puts "#{@red}An error occurred when running: #{cmd}. Is #{@default_editor} installed?#{@white}"
    exit 1
  end
end

def remove(name)
  path = "#{@notes_dir}/#{name}"
  if File.exists? path
    system("rm #{path}")
    puts "#{@green}Removed note #{name}#{@white}"
  end
end

def set_editor(editor)
  @conf["editor"] = editor
  @default_editor = editor
  File.open(@conf_file, "w") {|f| YAML.dump(@conf, f) }
  puts "#{@green}Editor changed to #{editor}#{@white}"
end

def set_notes_dir(dir)
  @conf["notes_dir"] = dir
  @notes_dir = dir
  File.open(@conf_file, "w") {|f| YAML.dump(@conf, f) }
  Dir.mkdir dir if !Dir.exists? dir
  puts "#{@green}Notes directory set to #{dir}#{@white}"
end

def start_enote
  if File.exists? @conf_file
    begin
      ARGV << '-h' if ARGV.empty?
      (ARGV[0][0] != "-") ? (edit ARGV[0]) : @op.parse!
    rescue OptionParser::MissingArgument => e
      puts "#{@red}An error occurred: #{e.message}.#{@white}"
      puts
      puts @op
      exit 2
    end
  else
    puts "#{@red}ENote is not installed for current user. Install by running './install'#{@white}"
  end
end
