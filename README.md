<h1 align="center">brew-auto-upgrade</h1>
<p align="center">A step-by-step guide on how to create a macOS LaunchAgent that upgrades homebrew every morning. ☕️</p>

<br/>
<img width="1081" height="396" alt="brew-auto-upgrade-notice" src="https://github.com/user-attachments/assets/bbf247df-3ff8-486c-8415-bff2207a19f3" />

## Why this repo?
Since the dawn of Mac OS X, later macOS, man has always missed what in the Linux world can be considered as important as air and water: <i>a native package manager</i>. This still hasn't become a reality, but suddenly we had our lord and saviour Max Howell create what is today known as Homebrew. 

Homebrew is a basically a tool that lets you download the stuff that Apple doesn't, everything from git to terminal tetris. And that's not all; using casks even GUI applications can be installed. It truly, <i>truly</i> facilitates everyday life for us developers and paves the way for a joyful experience when installing new software. <b>But there is catch.</b>

<b>The thing is, if you're not as disciplined as [Stephen scheduling his `brew upgrade`'s in his Things list](https://dev.to/stephencweiss/keep-homebrew-formulae-up-to-date-3p7b), things will sooner-than-later get outdated.</b>

Us Gen Z's are the laziest generation out there, and the last thing we and everyone else wants to do is remember to update our packages. <i>"Tommy, don't forget to update your packages before you go visit Nanny!"</i>💀

### Why should I care?
🪲 **Bug-free -** Old packages can have bugs that make things break or act weird. Updates usually fix those bugs so stuff works better.

🥷 **Hackerman? No thank you. -** Hackers love old software. Updates patch up security holes that bad guys could take advantage of.

💨**Smooooooth -** Other software on your computer might expect the latest versions to be installed. No update, no fun.

### Thanks to my predecessors, but it wasn't good enough

Tons of ready-made solutions exist (brew-autoupdate which [stopped being official March 2024](https://github.com/Homebrew/brew/pull/16822)), but all of them fail to be easy to set up or are way too hard to understand how they work. I wanted to keep it simple.

## Installation
It will take under 1 minute I promise!
### Part 1 of 3: The update script
1.1. Create a directory for the script
```bash
mkdir -p $HOME/scripts
```
1.2. Copy the `brew-auto-upgrade.sh` script to the folder, and change the following:
- `TIMESTAMP_FILE` and `LOG_FILE` based on where you created your directory in 1.
- **If you run an Intel Mac**, edit all occurences of `/opt/homebrew/bin/brew` to `/opt/homebrew/brew`

1.3. Make the script executable:
```bash
chmod +x $HOME/scripts/brew-auto-upgrade.sh
```

### Part 2 of 3: The LaunchAgent file
2.1 Copy the file `com.user.brew-auto-upgrade.plist` to the following location:
```
$HOME/Library/LaunchAgents/com.user.brew-auto-upgrade.plist
```
2.2 Load the LaunchAgent:
```bash
launchctl load $HOME/Library/LaunchAgents/com.user.brew-auto-upgrade.plist
```
### Part 3 of 3: Enable notification from Script Editor
3.1 Open the Script Editor app, create a new file and paste in the following dummy content:
```
display notification "pong" with title "ping" sound name "Basso"
```
3.2 Run the script from the top right corner, and then enable Notifications by the Script Editor app

```
                            __/\__
                            \    /
                            /_  _\         ___                                     .           /
                              \/         .'   \   __.  , __     ___. .___    ___  _/_     ____ |
                                         |      .'   \ |'  `. .'   ` /   \  /   `  |     (     |
                                         |      |    | |    | |    | |   ' |    |  |     `--.  |
             ,   ,   ,   ,                `.__,  `._.' /    |  `---| /     `.__/|  \__/ \___.' `
           , |_,_|_,_|_,_| ,                                   \___/                           '
       _,-=|;  |,  |,  |,  |;=-_
     .-_| , | , | , | , | , |  _-.
     |:  -|:._|___|___|__.|:=-  :|
     ||*:  :    .     .    :  |*||
     || |  | *  |  *  |  * |  | ||
 _.-=|:*|  |    |     |    |  |*:|=-._
-    `._:  | *  |  *  |  * |  :_.'    -
 =_      -=:.___:_____|___.: =-     _=
    - . _ __ ___  ___  ___ __ _ . -
```
