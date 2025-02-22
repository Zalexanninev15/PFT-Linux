# PFT Linux | [Latest release](https://github.com/Zalexanninev15/PFT-Linux/releases/latest)

[![](https://img.shields.io/badge/platform-Linux-ligthgreen?logo=linux)](https://github.com/Zalexanninev15/PFT-Linux)
[![](https://img.shields.io/badge/written_on-GNU_Bash-%234EAA25.svg?logo=gnubash)](https://github.com/Zalexanninev15/PFT-Linux)
[![](https://img.shields.io/github/v/release/Zalexanninev15/PFT-Linux)](https://github.com/Zalexanninev15/PFT-Linux/releases/latest)
[![](https://img.shields.io/badge/versions-changelog-7D28CC.svg)](https://github.com/Zalexanninev15/PFT-Linux/blob/master/Changelog.md)
[![](https://img.shields.io/github/downloads/Zalexanninev15/PFT-Linux/total.svg)](https://github.com/Zalexanninev15/PFT-Linux/releases)
[![](https://img.shields.io/github/last-commit/Zalexanninev15/PFT-Linux)](https://github.com/Zalexanninev15/PFT-Linux/commits/master)
[![](https://img.shields.io/github/stars/Zalexanninev15/PFT-Linux.svg)](https://github.com/Zalexanninev15/PFT-Linux/stargazers)
[![](https://img.shields.io/github/forks/Zalexanninev15/PFT-Linux.svg)](https://github.com/Zalexanninev15/PFT-Linux/network/members)
[![](https://img.shields.io/github/issues/Zalexanninev15/PFT-Linux.svg)](https://github.com/Zalexanninev15/PFT-Linux/issues?q=is%3Aopen+is%3Aissue)
[![](https://img.shields.io/github/issues-closed/Zalexanninev15/PFT-Linux.svg)](https://github.com/Zalexanninev15/PFT-Linux/issues?q=is%3Aissue+is%3Aclosed)
[![](https://img.shields.io/badge/Пост_на_4PDA-0072BC?logo=android&logoColor=mediumspringgreen&borderRadius=30)](https://4pda.to/forum/index.php?showtopic=952274&view=findpost&p=94908974)
[![](https://img.shields.io/badge/Telegram_канал-FFFFFF.svg?logo=telegram)](https://t.me/ZTEBV9VitaNews)
[![](https://img.shields.io/badge/license-GPLv3-ligthgreen.svg)](LICENSE)
[![](https://img.shields.io/badge/Donate-FFDD00.svg?logo=buymeacoffee&logoColor=black)](https://z15.neocities.org/donate)

## Screenshot of PFT port by Zalexanninev15 (left) and jno (right)

<a href="https://ibb.co/SQTB9Vx"><img src="https://i.ibb.co/PTpgf1Y/7RKKdsU.png" alt="7RKKdsU" border="0"></a>

## Main authors of PFT

* [friendki11er](https://4pda.to/forum/index.php?showuser=198744) - author of the original PFT tool for Windows, file to get half-root rights ([post with PFT](https://4pda.to/forum/index.php?s=&showtopic=952274&view=findpost&p=85383238))
* [jno](https://4pda.to/forum/index.php?showuser=312616) - ported PFT for Linux ([original port of PTF on Linux](https://jno.undo.it/cgi-bin/fossil.cgi/PFT4pda/doc))
* [Zalexanninev15](https://4pda.to/forum/index.php?showuser=5330563) - minor edits for PTF port for Linux, exclusive installer, new PFT port for Linux and PFT Linux Project

## Description

Installer (for tools) & tools for flash & dump partitions for ZTE Blade V9 Vita and ZTE Blade A7 Vita for Linux. Tools used ADB and [emmcdl](https://github.com/Zalexanninev15/emmcdl).

## System requirements

* **Linux:** Mint/Ubuntu/Debian, Manjaro
* **Additional:** Internet (only for installer)

## Instruction for use

1. Download and run [this](https://github.com/Zalexanninev15/PFT-Linux/releases/latest/download/install) script for the correct install "adb", "emmcdl" and PFT Linux
2. Run the script "pft.sh" ("./pft.sh") (port by jno) or "npft" (port by Zalexaninnev15)

#### Instructions for PFT Linux by Zalexanninev15. For PFT port by jno see [here](https://jno.undo.it/cgi-bin/fossil.cgi/PFT4pda/doc)

1. Write "8", write your password and re-login in to your account
2. Write "7" and write your password
3. Set your smartphone into EDL mode:

* ADB: Write "2" and wait
* DFU: point 4, write "1", point 4 (the port may change, so it may be necessary to change it (enter "H" when they ask about the port, then follow the instructions and the port will be checked))

4. Check the appearance of the diagnostic port "/dev/ttyUSB0". Write "9" and "S"
5. Flash and Backup (but it has not yet been implemented, so use the [port by jno](https://jno.undo.it/cgi-bin/fossil.cgi/PFT4pda/doc))

## All Errors of emmcdl ([source](https://github.com/Zalexanninev15/PFT2#all-errors-of-flasher-emmcdl))

#### Status: 21 The device is not ready

Most likely your smartphone has left EDL mode, enter this mode again.

#### WARNING: Flash programmer failed to load trying to continue

Maybe this is a crash in emmcdl. If the flash/dump is on, then you should not worry, but if not, then it is worth putting your smartphone back into EDL mode.

#### Status: 2 The system cannot find the file specified

An error may occur due to spaces in the path (folder) to something. You should also check for the availability of the file.

#### Status: 6 The handle is invalid

Failure to work with diagnostic port. You should again transfer the smartphone to EDL mode.
