def notes?
  !Dir["#{@notes_dir}/*"].entries.empty?
end

def list
  if notes?
    notes = `ls #{@notes_dir}`.split("\n").select { |n| (ARGV - (@tags[n.to_s] ||= [])).empty? }
    notes.each do |note|
      note_tags = @tags[note.to_s]
      if note_tags.nil? || note_tags.empty?
        puts note.to_s
      else
        puts "#{note} (tags: #{note_tags.join(', ')})"
      end
    end
  else
    puts 'No notes created yet'
  end
end

def edit(name)
  cmd = "#{@default_editor} #{@notes_dir}/#{name}"
  system(cmd)
  if $CHILD_STATUS.exitstatus != 0
    puts "#{@red}An error occurred when running: #{cmd}. Is #{@default_editor} installed?#{@white}"
    exit 1
  end
end

def rename
  @arguments -= ['-r', '--rename']
  note = @arguments[0]
  new_note = @arguments[1]
  if @arguments.size < 2
    puts "#{@red}Enter at least two arguments#{@white}"
    puts @op
    exit 1
  end
  cmd = "mv #{@notes_dir}/#{note} #{@notes_dir}/#{new_note}"
  system(cmd)
  if $CHILD_STATUS.exitstatus != 0
    puts "#{@red}An error occurred when running: #{cmd}."
    exit 1
  end
  @tags[new_note.to_s] = @tags[note.to_s]
  @tags.delete(note.to_s)
  write_conf
  puts "#{@green}#{note} renamed to #{new_note}#{@white}"
end

def remove(name)
  path = "#{@notes_dir}/#{name}"
  if File.exist? path
    system("rm #{path}")
    @tags.delete_if { |k, _v| k == name || k == name.to_s }
    write_conf
    puts "#{@green}Removed note #{name}#{@white}"
  end
end

def tag_note
  f = @arguments[0]
  tagging = (f == '-t' || f == '--tag')
  @arguments -= ['-t', '--tag', '-u', '--untag']
  if @arguments.size < 2
    puts "#{@red}Enter at least two arguments#{@white}"
    puts @op
    exit 1
  end
  note = @arguments.shift
  if File.exist? "#{@notes_dir}/#{note}"
    @arguments.each do |tag|
      note_tags = (@tags[note.to_s] ||= [])
      has_tag = (note_tags.include? tag)
      note_tags << tag if !has_tag && tagging
      note_tags.delete(tag) if has_tag && !tagging
    end
    write_conf
    if tagging
      puts "#{@green}Tagged #{note} as #{@arguments.join(', ')}#{@white}"
    else
      puts "#{@green}Removed tags #{@arguments.join(', ')} from #{note}#{@white}"
    end
  else
    puts "#{@red}Note '#{note}' does not exist#{@white}"
    exit 1
  end
end

def write_conf
  File.open(@conf_file, 'w') { |f| YAML.dump(@conf, f) }
end

def editor(editor)
  @conf['editor'] = editor
  @default_editor = editor
  write_conf
  puts "#{@green}Editor changed to #{editor}#{@white}"
end

def notes_dir(dir)
  @conf['notes_dir'] = dir
  @notes_dir = dir
  write_conf
  Dir.mkdir dir unless Dir.exist? dir
  puts "#{@green}Notes directory set to #{dir}#{@white}"
end

def start_enote
  if File.exist? @conf_file
    begin
      ARGV << '-h' if ARGV.empty?
      @arguments += ARGV
      ARGV[0][0] != '-' ? (edit ARGV[0]) : @op.parse!
      f = @arguments[0]
      if ['-t', '-u', '--tag', '--untag'].include? f
        tag_note
      elsif ['-r', '--rename'].include? f
        rename
      end
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
