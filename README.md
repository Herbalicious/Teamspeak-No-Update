# Teamspeak No Update Ver.2.3

This is a batch script that stops teamspeak from asking you if you want to update every time you open it. I got tired of manually fiddling with stuff, so I wrote this.

### Explanation

Every time you open Teamspeak, the client has to go through the internet and ask the main Teamspeak server: "Hey, is there a new update for me?" If there is, that information gets sent back to ask you if you want to update. For whatever unknown god-forsaken reason, Teamspeak decided that you should never be able to deactivate this, even though their updates tend to break all of your plug-ins. So, after getting tired of this, I opened up wireshark to see the highway it took to ask the server if there's an update. The only three teamspeak addresses it used were `versions.teamspeak.com`, `news.teamspeak.com` and `clientapi.myteamspeak.com`. I'm throwing my bets on the fact that `versions.teamspeak.com` is probably the one that tells you if there's a new version available, and told (or will tell) your computer that instead of looking up where that is, it's actually located at 127.0.0.1; AKA your own computer. After that, it gets no information about updates and goes "Well, I guess there isn't any!" and it won't bother you. That's how it's supposed to work at least.

### Installation

* Download a .zip of the file(s) here.  
* Extract the .zip anywhere you want, (I recommend placing the "TSNU" folder in your Teamspeak 3 installation directory).  
* Run the TSNU.bat.
* You're done! No more annoying pop-ups every time you open the damn program.  

### Removal

* Find where you put the files (Teamspeak 3 installation folder, maybe?)
* Run "TSNU.bat".
* You're done! Now it will ask you if you want to update when you open teamspeak.

### Versions

* `Ver.1.0` - Worked, but left behind empty lines in the hosts file.  
* `Ver.1.1` - Added a findstr for empty lines to delete those as well.  
* `Ver.1.2` - Made it slightly more visually appealing.  
* `Ver.2.0` - Now compressed to a single file!
* `Ver.2.1` - Hopefully made it work for the newer teamspeak update URL.
* `Ver.2.2` - Small visual updates.
* `Ver.2.3` - Now includes a section to automatically detect and ask for administrator, instead of requiring you to manually run as Admin.

### Authors

* **Herbal Beverage** - The Big Annoyed
