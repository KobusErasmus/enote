@op = OptionParser.new
@op.banner = "Manage notes in favourite command line text editor.

Usage: #{File.basename($PROGRAM_NAME)} [option]...[note]..."
@op.on("-l", "--list", "list all notes") {list}
@op.on("-e", "--edit NOTE", "edit or create new note called NOTE") {|n| edit n}
@op.on("-r", "--remove NOTE", "remove note called NOTE") {|n| remove n}
@op.on("--set-editor VALUE", "set default editor to VALUE (e.g. vim)") {|v| set_editor v}
@op.on("--set-notes-dir VALUE", "set notes directory to VALUE") {|v| set_notes_dir v}
@op.on("-h", "--help", "Prints this help") {puts @op; exit}
