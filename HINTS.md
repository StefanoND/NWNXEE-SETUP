# Multiple instances for online play

If you have two or more CD-Keys (either from Steam, GOG, Beamdog and/or other places) you can install them through
their respective launcher and assign each of them the `-userDirectory` launch argument followed by nwn's document path.

This is useful if you're a module builder and/or server owner and need to test your scripts/systems and need two
instances of the game in the same (Online/LAN) server.

### Windows users

    The My Documents path is at "C:\Users\USERNAME\Documents".
    Instead of using Lutris, you can use GOG/Beamdogs/etc's own launcher(s).

### The most important thing is that you have two or more separate "cdkey.ini" files, each with a different CD-Key and each in their respective NWN Document folder.

Example for Linux:

### Step 1 - Install NWN: EE on your first launcher (Example: Steam)

    Run NWN: EE once
    A new folder will be created at "~/.local/share" called "Neverwinter Nights"
    Rename it to your liking, for example "STEAM_Neverwinter-Nights"
    Open Steam Library, right-click "Neverwinter Nights: Enhanced Edition" and select "Properties"
    In "General" tab, "Launch Options" section, you'll put
    -userDirectory "/home/USERNAME/.local/share/STEAM_Neverwinter-Nights"

### Step 2 - Install NWN: EE on your second launcher (Example: GOG through Lutris)

    Run NWN: EE once
    A new folder will be created at "~/.local/share" called "Neverwinter Nights"
    Rename it to your liking, for example "GOG_Neverwinter-Nights"
    Open Lutris and right-click on the "Neverwinter Nights: Enhanced Edition" and select "Configure"
    In "Game Options" tab, change the "Executable" to "/path/to/lutris/nwnee/nwmain-linux"*
    In "Arguments" put
    -userDirectory "/home/USERNAME/.local/share/GOG_Neverwinter-Nights"
    Click on "Save"

\*: Example path is "/home/USERNAME/Lutris/gog/neverwinter-nights-enhanced-edition/game/bin/linux-x86/nwmain-linux"

### Step 3 - Configure the nwn.ini files

Since you have two or more different NWN Documents folder, you have two or more different "nwn.ini" files,
all pointing to their original `~/.local/share/Neverwinter Nights` path.

You can configure them however you like, you can configure to point them to their respective nwn documents folder or point to another folder, it's up to you.

In my case I have the "correct" documents folder in my external drive and I changed all nwn.ini's to point to it.

Example:

The path to my nwn documents folder is `/mnt/EXTERNALDRIVE/NWN_DOCS` so all my nwn.ini files would look like this:

    [Alias]
    HD0=/mnt/EXTERNALDRIVE/NWN_DOCS
    MODULES=/mnt/EXTERNALDRIVE/NWN_DOCS/modules
    SAVES=/mnt/EXTERNALDRIVE/NWN_DOCS/saves
    OVERRIDE=/mnt/EXTERNALDRIVE/NWN_DOCS/override
    HAK=/mnt/EXTERNALDRIVE/NWN_DOCS/hak
    SCREENSHOTS=/mnt/EXTERNALDRIVE/NWN_DOCS/screenshots
    CURRENTGAME=/mnt/EXTERNALDRIVE/NWN_DOCS/currentgame
    LOGS=/mnt/EXTERNALDRIVE/NWN_DOCS/logs
    TEMP=/mnt/EXTERNALDRIVE/NWN_DOCS/temp
    TEMPCLIENT=/mnt/EXTERNALDRIVE/NWN_DOCS/tempclient
    LOCALVAULT=/mnt/EXTERNALDRIVE/NWN_DOCS/localvault
    DMVAULT=/mnt/EXTERNALDRIVE/NWN_DOCS/dmvault
    SERVERVAULT=/mnt/EXTERNALDRIVE/NWN_DOCS/servervault
    DATABASE=/mnt/EXTERNALDRIVE/NWN_DOCS/database
    PORTRAITS=/mnt/EXTERNALDRIVE/NWN_DOCS/portraits
    AMBIENT=/mnt/EXTERNALDRIVE/NWN_DOCS/ambient
    MOVIES=/mnt/EXTERNALDRIVE/NWN_DOCS/movies
    MUSIC=/mnt/EXTERNALDRIVE/NWN_DOCS/music
    TLK=/mnt/EXTERNALDRIVE/NWN_DOCS/tlk
    DEVELOPMENT=/mnt/EXTERNALDRIVE/NWN_DOCS/development
    PATCH=/mnt/EXTERNALDRIVE/NWN_DOCS/patch
    OLDSERVERVAULT=/mnt/EXTERNALDRIVE/NWN_DOCS/oldservervault
    NWSYNC=/mnt/EXTERNALDRIVE/NWN_DOCS/nwsync
    CACHE=/mnt/EXTERNALDRIVE/NWN_DOCS/cache
    MODELCOMPILER=/mnt/EXTERNALDRIVE/NWN_DOCS/modelcompiler

# Toolset in Linux

If you're using the toolset in Linux, it'll be using WINE or PROTON and it will create yet another
"Neverwinter Nights" folder.

If you're using WINE, your ~/Documents folder is WINE's documents folder and it's nwn.ini file will be pointing to it like
`C:\users\USERNAME\Documents\Neverwinter Nights`.

If you're using PROTON, PROTON's Documents folder is at
`/path/to/steamapps/compatdata/XXXX/pfx/drive_c/users/steamuser/Documents/Neverwinter Nights/`

    If NWN: EE's installed in your own drive, the "/path/to/steamapps" is `/home/USERNAME/.local/share/Steam/steamapps/`
    If NWN: EE's installed in an external drive, the "path/to/steamapps" is `/path/to/SteamLibrary/steamapps/`

The `XXXX` look like random numbers, if you have multiple games running under PROTON, you'll have to check each folder,
for the correct one.

PROTON's nwn.ini will be pointing to `C:\users\steamuser\Documents\Neverwinter Nights`

If you have the "correct" nwn documents folder in another place, you'll have to change it.

To access paths "outside" WINE/PROTON, you'll need to put the path to WINE/PROTON's dosdevices like:

    WINE: `\path\to\.wine\dosdevices` (with backslash)
    PROTON: `\path\to\steamapps\compatdata\XXXX\pfx\dosdevices` (with backslash)

and then from there, the path to the "correct" nwn documents like `z:\mnt\EXTERNALDRIVE\NWN_DOCS` like this:

    WINE: \home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS
    PROTON: `\path\to\steamapps\compatdata\XXXX\pfx\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS

So in your nwn.ini, it'll look like this (Adjust accordingly for PROTON):

    [Alias]
    HD0=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS
    MODULES=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\modules
    SAVES=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\saves
    OVERRIDE=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\override
    HAK=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\hak
    SCREENSHOTS=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\screenshots
    CURRENTGAME=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\currentgame
    LOGS=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\logs
    TEMP=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\temp
    TEMPCLIENT=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\tempclient
    LOCALVAULT=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\localvault
    DMVAULT=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\dmvault
    SERVERVAULT=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\servervault
    DATABASE=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\database
    PORTRAITS=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\portraits
    AMBIENT=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\ambient
    MOVIES=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\movies
    MUSIC=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\music
    TLK=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\tlk
    DEVELOPMENT=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\development
    PATCH=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\patch
    OLDSERVERVAULT=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\oldservervault
    NWSYNC=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\nwsync
    CACHE=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\cache
    MODELCOMPILER=home\USERNAME\.wine\dosdevices\z:\mnt\EXTERNALDRIVE\NWN_DOCS\modelcompiler
