UUP dump Development Server
---------------------------

### Description
A tool meant to make setting up UUP dump development environment on Windows
as easy as extracting an archive and running a few scripts.

### How to use?
When running for the first time you need to run `update.cmd` script to
automatically download latest revision of UUP dump with its latest dependencies.

To run the server simply run `run.cmd` script. It will open automatically your
default browser with UUP dump loaded. Server needs Microsoft Visual C++ 2017
Redistributable to be installed in order to work.

To retrieve the latest UUP dump with its latest dependencies run `update.cmd`.

If PHP for some reason does not work, check console window for details.

### Projects used in this project
  - aria2 (https://aria2.github.io/)
  - PHP (http://php.net/)
