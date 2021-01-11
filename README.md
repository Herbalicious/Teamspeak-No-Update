# Teamspeak No Update Ver.3.0

This is a simple batch script that stops teamspeak from asking you if you want to update every time you open it.

### Explanation
Every time you open Teamspeak, it pings the update server and brings up a pop-up if there is an update. This is good, but also a fucking nuisance if you don't want to update TS for whatever reason, such as plug-in support.

### Installation

* Download the file(s) from [here](https://github.com/Herbalicious/Teamspeak-No-Update/archive/3.0.zip).  
* Extract and run TSNU.bat anywhere you want (I recommend placing it in your TS3 folder, or anywhere else you'll be able to easily find it).  
* Select 1. to Install
* You're done! No more annoying pop-ups every time you open the damn program.  

### Removal

* Find where you put the files (TS3 installation folder, maybe?)
* Run "TSNU.bat"
* Select 2. Uninstall
* You're done!

### Versions

* `Ver.1.0` - Works, but leaves behind empty lines in the hosts file.  
* `Ver.1.1` - Added a findstr for empty lines to delete those as well.  
* `Ver.1.2` - Made it slightly more visually appealing.  
* `Ver.2.0` - Now compressed to a single file!
* `Ver.2.1` - Hopefully made it work for the new teamspeak update URL.
* `Ver.2.2` - Small visual updates.
* `Ver.2.3` - Now includes a section to automatically detect and ask for administrator, instead of requiring you to manually run as Admin.
* `Ver.3.0` - Another complete rewrite for readability as well as calling some new menus and some stuff I leaned from other projects.

### Authors

* **Herbal** - Very Annoyed
