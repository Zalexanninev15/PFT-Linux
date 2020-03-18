#!/bin/bash

*==================================*
*                                  *
*     Partitions Flashing Tool     *
*                                  *
*               for                *
*                                  *
*       ZTE Blade V9 Vita          *
*       ZTE Blade A7 Vita          *
*                                  *
*     Created by Zalexanninev15    *
*                                  *
*==================================*
read -r -p '-- Press Enter to continue --'

while [ $menu != "6"]
do
clear
echo ************************************
echo *        Choose a command:         *
echo *                                  *
echo *        1) DFU to EDL             *
echo *        2) ADB to EDL             *
echo *                                  *
echo *      3) Backup partition         *
echo *      4) Flash partition          *
echo *   5) Backup all partitions       *
echo *                                  *
echo *           6) Exit                *
echo *                                  *
echo ************************************
read $menu

if [ $menu = "1" ] # SOON!

if [ $menu = "2"]
then
	adb reboot edl 
fi

if [ $menu = "3" ] # SOON!

if [ $menu = "4" ] # SOON!

if [ $menu = "5" ] # SOON!

done

