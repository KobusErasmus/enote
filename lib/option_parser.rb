@op = OptionParser.new
@op.banner = "Manage notes in favourite command line text editor.

Usage: #{File.basename($PROGRAM_NAME)} [option]...[note]..."
@op.on('-l', '--list', 'list all notes') { list }
@op.on('-e', '--edit NOTE', 'edit or create new note called NOTE') { |n| edit n }
@op.on('-r', '--rename NOTE NEW_NOTE', 'rename note called NOTE to NEW_NOTE')
@op.on('-d', '--delete NOTE', 'delete note called NOTE') { |n| remove n }
@op.on('-t', '--tag NOTE TAG TAG ...', 'assign TAG[s] to NOTE')
@op.on('-u', '--untag NOTE TAG TAG ...', 'remove TAG[s] for NOTE')
@op.on('--set-editor VALUE', 'set default editor to VALUE (e.g. vim)') { |v| editor v }
@op.on('--set-notes-dir VALUE', 'set notes directory to VALUE') { |v| notes_dir v }
@op.on('-h', '--help', 'Prints this help') { puts @op; exit }
