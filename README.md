# PFT Linux

## Screenshot of PFT port by Zalexanninev15 (left) and jno (right)
![](https://i.imgur.com/7RKKdsU.png)

## Main authors of PFT
* [friendki11er](https://4pda.ru/forum/index.php?showuser=198744) - author of the original PFT tool for Windows, file to get half-root rights ([post with PFT](https://4pda.ru/forum/index.php?s=&showtopic=952274&view=findpost&p=85383238))
* [jno](https://4pda.ru/forum/index.php?showuser=312616) - ported PFT for Linux ([original port of PTF on Linux](https://jno.undo.it/cgi-bin/fossil.cgi/PFT4pda/doc))
* [Zalexanninev15](https://4pda.ru/forum/index.php?showuser=5330563) - minor edits for PTF port for Linux, exclusive installer, new PFT port for Linux and PFT Linux Project

## Description
Tool for flash/dump partitions for ZTE Blade V9 Vita and ZTE Blade A7 Vita for Linux. The tool used ADB and emmcdl tools. 

## System requirements
* Linux distros for: Mint/Ubuntu/Debian, possibly others
* Additional: Internet (only for Installer)

## Instruction for use
1. Download and run [this](https://github.com/Zalexanninev15/PFT-Linux/releases/latest/download/install) script for the correct use and configuration of PFT. After reboot please open the folder "PFT-Linux"
2. Run the script "pft.sh" (port by jno) or "npft" (port by Zalexaninnev15)

## All Errors of emmcdl ([source](https://github.com/Zalexanninev15/PFT2#all-errors-of-flasher-emmcdl))
#### Status: 21 The device is not ready: 
Most likely your smartphone has left EDL mode, enter this mode again.
#### WARNING: Flash programmer failed to load trying to continue:
Maybe this is a crash in emmcdl. If the flash/dump is on, then you should not worry, but if not, then it is worth putting your smartphone back into EDL mode.
#### Status: 2 The system cannot find the file specified:
An error may occur due to spaces in the path (folder) to something. You should also check for the availability of the file.
#### Status: 6 The handle is invalid:
Failure to work with COM port. You should again transfer the smartphone to EDL mode.
