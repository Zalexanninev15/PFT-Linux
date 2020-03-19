#!/bin/bash

echo
echo "************************************"
echo "*                                  *"
echo "*    Partitions Flashing Tool      *"
echo "*                                  *"
echo "*               for                *"
echo "*                                  *"
echo "*       ZTE Blade V9 Vita          *"
echo "*       ZTE Blade A7 Vita          *"
echo "*                                  *"
echo "*     Created by Zalexanninev15    *"
echo "*                                  *"
echo "************************************"
echo
read -r -p '-- Press Enter to continue --'

while [[ $menu != 7 ]]
do
echo
echo "************************************"
echo "*        Choose a command:         *"
echo "*                                  *"
echo "*        1) DFU 👉️ EDL             *"
echo "*        2) ADB 👉️ EDL             *"
echo "*                                  *"
echo "*      3) Backup partition         *"
echo "*      4) Flash partition          *"
echo "*   5) Backup all partitions       *"
echo "*                                  *"
echo "*     6) Stop ModemManager         *"
echo "*(for more stable work in EDL mode)*"
echo "*                                  *"
echo "*           7) Exit                *"
echo "*                                  *"
echo "************************************"
read menu
echo

if [[ $menu = 1 ]] # SOON!
then
  menu="0"
fi

if [[ $menu = 2 ]]
then
	echo "Reboot to EDL mode..."
	adb reboot edl 
fi

if [[ $menu = 3 ]] # SOON!
then
   menu="0"
fi

if [[ $menu = 4 ]] # SOON!
then
   menu="0"
fi

if [[ $menu = 5 ]] # SOON!
then
   menu="0"
fi

if [[ $menu = 6 ]]
then 
   sudo systemctl stop ModemManager
fi

done

