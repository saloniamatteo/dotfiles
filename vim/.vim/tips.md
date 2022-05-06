# Vim tips and tricks

**`:vs`** = vertical split

**`:1,5command`** = run a command for lines 1 to 5

**`:.command`** = run a command for the current line

**`:$command`** = run a command at the end of the file

**`:%command`** = run a command for the entire document

**`:.,.+5command`** = run a command from the current line + 5 lines

**`:g/pattern/command`** = search a pattern globally in the document and run a vim command
(for example delete all lines that include the word "import" = **`:g/import/d`**)
(for example put a new line after every line = **`:g/^/pu =\"\n\"`**)
(for example delete all empty lines = **`:g/^\s*$/d`**)
(for example copy all lines containing the word "import" to the end of the file = **`:g/import/t$`**)
(for example move all lines containing the word "import" to the end of the file = **`:g/import/m$`**)
(for example reverse a document = **`:g/^/m0`**)

**`:g!/pattern/command`** = search in the file all the words that do not contain a pattern and run a vim command (this is the inverse of :g/pattern/command)

**`:v/pattern/command`** = same as **`:g!/pattern/command`**

**`:1,10norm itext`** = from lines 1 to 10 prepend the text "text"

**`:1,10norm Atext`** = from lines 1 to 10 append the text "text"

While in normal mode, if you press <kbd>m</kbd> + a random letter, like <kbd>a</kbd>, you will set a bookmark of your current position to <kbd>a</kbd>. If you want to access the bookmark saved in <kbd>a</kbd>, press <kbd>'</kbd>+<kbd>a</kbd>.
