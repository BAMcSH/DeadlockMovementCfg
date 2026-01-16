
# Deadlock Movement Config

Cfgs and scripts to help learn Deadlock movement with features like hotkey position save/restore and collections of spots with hints.

## Intstructions

Place the poswatch.ps1 file in your Deadlock folder.
Place the other cfg files from the drive folder into "..\Deadlock\game\citadel\cfg"

Either add "-condebug" to your Deadlock launch options and start the powershell script manually, or...
Place startup.bat next to poswatch.ps1 in your Deadlock folder.
Then replace your Deadlock launch options with:
"startup.bat" %COMMAND%
(quotes included)
You can open startup.bat and place launch options for deadlock behind deadlock.exe if needed.

Open leiftoolspwsh.cfg to change the 5 and 6 to the keys you'd like for cycling spots. 
Visit pos_tools.cfg to change other keybinds.

Default binds:
O - save position
H - load position
F8 - Start testing map
F9 - Swap teams
F10 - Setup the map (stop trooper spawns, spawn neutrals, enable sandbox overlay)
F12 - Toggle HUD on and off

If you use the .bat option, you may need to re-enable the console in your Deadlock settings.
Type leifhelp in the console to see my compiled lists of map positions.
Enter the names of any list to load them.

## Troubleshooting

If the save and restore functionality does not work, but everything else does, it is likely that the powershell script isn’t running. If the .bat file runs but the cmd prompt doesn’t remain open, this is also a sign that the powershell script is failing.

Here are steps to try:

1. Hit “Win + R” and type “powershell.exe”. When it opens, enter “Get-ExecutionPolicy -List”
2. If all the policies are Undefined, run “Set-ExecutionPolicy -Scope CurrentUser RemoteSigned”
3. Now right click the properties of the poswatch.ps1 file. There may be settings related to it being blocked, as in this images circled area:
![/example.jpg](https://github.com/BAMcSH/DeadlockMovementCfg/blob/main/example.png)
5. If it is blocked, then unblock it here and Apply. The script should now run.

Alternatively, you can set your execution policy to “Unrestricted”, which will allow scripts downloaded from the internet to run without being unblocked first, and see if it works that way. I wouldn’t recommend leaving this setting this way.
