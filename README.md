# ENote
A simple Ruby script to manage notes in favourite command line text editor.

# Install
To install ENote, first open your terminal and type the following:
```
git clone https://github.com/KobusErasmus/enote.git && cd enote && ./install
```
Then open up a new terminal window (ctrl+shift+t) to enjoy ENote.

# Usage
To view options, type:
```
enote
```
To add/edit a note called "MyNote", type:
```
enote MyNote
```
To list all your notes, type:
```
enote -l
```
To list all your notes that have the tag, say, "MyFirstTag", type:
```
enote -l MyFirstTag
```
To rename a note called "MyNote" to "my-note", type:
```
enote -r MyNote my-note
```
To remove a note called "MyNote", type:
```
enote -d MyNote
```
To add the tags MyFirstTag and tag1 to note MyNote, type:
```
enote -t MyNote MyFirstTag tag1
```
To remove the tags MyFirstTag and tag1 from note MyNote, type:
```
enote -u MyNote MyFirstTag tag1
```
To change default text editor to, for example, vim, type:
```
enote --set-editor vim
```

# Uninstall
To uninstall ENote, open your termianl, cd into the cloned directory, and type the following:
```
./uninstall
```

# About Author
Dr Jacobus Erasmus is a philosopher and programmer. For more information, see (www.JacobusErasmus.com).
