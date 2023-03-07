# parser (simple example of parsing swift source code)

open project with xcode -> edit main.swift file
you need to replace string in `let root = "paste here path to root folder of this project!"`
with correct path to this project

then run it, output will be:

```
s.FileLoader > s.Decl (22:0 Some Tag)
s.FileLoader > i.(path: String, tag: String)  (12:0 Some Tag)
s.FileLoader > f.loadContents (17:0 Some Tag)
s.FileLoader > f.collect (33:0 Some Tag)
s.FileLoader (8:0 Some Tag)
+.String > f.rowCol (56:0 Some Tag)
Program ended with exit code: 0
```

where s. is struct, i. is init, f. is function, +. is extesion, etc...


