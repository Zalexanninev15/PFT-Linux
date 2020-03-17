#!/bin/bash
# PFT Linux by jno & Zalexanninev15

base=$(dirname "$_") 
cd "$base"

error() {
	local -i rc=$1
	shift
	echo "ERROR($rc): $*" >/dev/tty
	exit $rc
}

for x in emmcdl adb fastboot; do
	type -P "$x" || error $? "No '$x' command."
done >/dev/null
for x in  partitions.txt tools/emmc.mbn; do
	[ -f "$x" ] || error 1 "No file '$x'."
done
for x in files/*.bin; do
	[ "$x" = 'files/*.bin' ] && error 1 "No 'files/*.bin' here."
done

TheGroup=''
grep -qw uucp /etc/group && TheGroup=uucp
grep -qw dialout /etc/group && TheGroup=dialout

if [ -z "${TheGroup}" ]; then
	TheGroup=dialout
	echo "!!! Cannot detect group. Assume '${TheGroup}' !!!"
fi >/dev/tty

cat >/dev/tty <<EOT
*=================================================*
*                                                 *
* Partitions Flashing Tool for ZTE Blade V9 Vita  *
*                                                 *
*             Made by friendki11er                *
*      Port on Linux by jno & Zalexanninev15      *
*                                                 *
*=================================================*

Read That Fine Manual at 
https://chiselapp.com/user/jno/repository/PFT4pda/doc
first!

EOT

if id -Gn | grep -qw "${TheGroup}"; then
	echo -n "Looks like you, '${LOGNAME:-$USER}', is "
	echo "already in the '${TheGroup}' group, good."
else
	cat <<EOT
Then check to see if you're in the proper group:
$(id -Gn | fold -sw50 | sed -e 's/^/: /')

You may need to run something like
	sudo adduser ${LOGNAME:-$USER} ${TheGroup}
and re-login.

EOT
fi >/dev/tty

if [ "$(systemctl is-active ModemManager)" = active ]
then
	cat <<EOT
!!!         You may brick your device           !!!

Do not forget to get rid of the ModemManager first!
	sudo systemctl stop ModemManager

EOT
fi >/dev/tty

echo
read -r -p '-- Press Enter to continue --'
echo

ls_usb_interfaces() {
	local -i n=0
	for i in `find -H /sys/bus/usb/devices/usb* -name interface`; do
		u=$(dirname $i)
		let n+=1
		(cd $u && echo -n "$u" &&
		 echo -n "|$(<../manufacturer)|$(<../product)|$(<interface)" &&
		 echo -n "|$(<../idVendor):$(<../idProduct)" &&
		 echo '')
	done
	(( n == 0 )) && echo "!!!   No USB *interfaces* found   !!!"
}

get_port() {
	local prompt="$*"
	local port=''
	{ lsusb; ls -l /dev/ttyUSB*; } >/dev/tty
	while [ -z "$port" ]; do
		read -r -p "${prompt}: " port </dev/tty
		[ -e "$port" ] && break
		[ -e "/dev/$port" ] && { port="/dev/$port"; break; }
		[ -e "/dev/tty$port" ] && { port="/dev/tty$port"; break; }
		echo "No port '$port'!"
		port=''
	done >/dev/tty
	local w=q r=q
	[ -r "$port" ] && r=readable || r=non-readable
	[ -w "$port" ] && w=writable || w=non-writable
	ls -l "$port" > /dev/tty
	echo "$prompt is '$port', $w, $r." > /dev/tty
	read -r -p '-- Press Enter to continue --' w < /dev/tty
	echo "$port"
}

get_partition() {
	local partn=''
	select partn in $(awk 'NF == 4 {print $2}' partitions.txt); do
		if grep -q " $partn " partitions.txt; then
			echo "Partition choosen is '$partn'." >/dev/tty
			echo "$partn"
			break
		fi
	done
}

check4edl() {
	local -i delay=${1:-2}
	sync
	if (( delay > 0 )); then
		local -i i=0
		echo -n "Wait... " >/dev/tty
		for ((i=0; i<delay; i++)); do echo -n '#'; sleep 1; done >/dev/tty
		echo ' .' >/dev/tty
	fi >/dev/tty
	ls_usb_interfaces >/dev/tty
	if lsusb | grep -w 9008; then
		echo "The device listed above is ready."
	else
		echo "!!! No device with PID=9008 found !!!"
		return 1
	fi >/dev/tty
	echo
}

dfu2edl() {
	if emmcdl -p "$(get_port DFU Port)" -raw 0xFE; then
		echo 'Done.'
		check4edl 2
	else
		cat <<EOT
*     !!!Failed to change DFU to EDL mode!!!      *
*                                                 *
*           Please check the following:           *
*                                                 *
*   1) DFU mode is active;                        *
*   2) DFU port was chosen properly;              *
*   3) USB cable is working.                      *
*                                                 *
EOT
	fi >/dev/tty
}

adb2edl() {
	adb devices
	if adb reboot edl; then
		echo 'Done.'
		check4edl 30
	else
		cat <<EOT
*     !!!Failed to change ADB to EDL mode!!!      *
*                                                 *
*           Please check the following:           *
*                                                 *
*   1) ADB Debugging is active;                   *
*   2) USB cable is working.                      *
*                                                 *
EOT
	fi >/dev/tty
}

fb2edl() {
	fastboot devices
	if fastboot oem edl; then
		echo 'Done.'
		check4edl 30
	else
		cat <<EOT
*   !!!Failed to change FastBoot to EDL mode!!!   *
*                                                 *
*           Please check the following:           *
*                                                 *
*   1) FastBoot can see the device;               *
*   2) USB cable is working.                      *
*                                                 *
EOT
	fi >/dev/tty
}

backup_partition() {
	local edlcom=$(get_port EDL Port) partn=$(get_partition)
	mkdir -p backup
	if emmcdl -p "$edlcom" -f tools/emmc.mbn -d "$partn" -o "backup/${partn}.bin"; then
		echo 'Done.'
	else
		cat <<EOT
*        !!!Failed to backup partition!!!         *
*                                                 *
*          Please check the following:            *
*                                                 *
*   1) EDL mode is active;                        *
*   2) EDL port was chosen properly;              *
*   3) USB cable is working;                      *
*   4) Target partition name is correct.          *
*                                                 *
EOT
	fi >/dev/tty
}

declare -a partitions2backup=(
	aboot abootbak apdp batweak boot cache cmnlib
	cmnlib64 cmnlib64bak cmnlibbak config DDR devcfg
	devcfgbak devinfo dip dpo dsp factory fingerid
	fsc fsg keymaster keymasterbak keystore limits
	logdump mcfg mdtp misc modem modemst1 modemst2
	mota msadp oem persist recovery rpm rpmbak sbl1
	sbl1bak sec splash ssd syscfg system tz tzbak
	vendor ztecfg userdata
)

backup_all_partitions() {
	local partn edlcom=$(get_port EDL Port)
	mkdir -p backup
	for partn in "${partitions2backup[@]}"; do
		if emmcdl \
			-p "$edlcom" \
			-f tools/emmc.mbn \
			-d "$partn" \
			-o "backup/${partn}.bin"
		then
			echo 'Done.'
		else
			cat <<EOT
*        !!!Failed to backup partition!!!         *
*                                                 *
*          Please check the following:            *
*                                                 *
*   1) EDL mode is active;                        *
*   2) EDL port was chosen properly;              *
*   3) USB cable is working;                      *
*   4) Target partition name is correct.          *
*                                                 *
EOT
		fi >/dev/tty
	done
}

flash_partition() {
	local edlcom=$(get_port EDL Port) partn=$(get_partition) flash=''
	select flash in files/*.bin; do
		[ -f "$flash" ] && break
		echo 'What??'
	done
	echo "Flashing '$flash' to partition '$partn' via '$edlcom'..." >/dev/tty
	if emmcdl -p "$edlcom" -f tools/emmc.mbn -b "$partn" "$flash"; then
		echo 'Done.'
	else
		cat <<EOT
*         !!!Failed to flash partition!!!         *
*                                                 *
*           Please check the following:           *
*                                                 *
*   1) EDL mode is active;                        *
*   2) EDL port was chosen properly;              *
*   3) USB cable is working;                      *
*   4) Target partition name is correct.          *
*                                                 *
EOT
	fi >/dev/tty
}

if check4edl; then echo "*** EDL ***"; else echo "--- NO EDL ---"; fi >/dev/tty
echo
echo Menu
select menu in \
	'DFU to EDL mode changer' \
	'ADB to EDL mode changer' \
	'Fastboot to EDL mode changer' \
	'Backup all partitions' \
	'Backup any partition' \
	'Flash any partition' \
	'EXIT'; do
	if [ -n "$menu" ]; then
		case "$menu" in
		EXIT)	echo "Bye."; exit;;
		DFU*)	dfu2edl;;
		ADB*)	adb2edl;;
		Fas*)	fb2edl;;
		Backup*partition)backup_partition;;
		Backup*partitions)backup_all_partitions;;
		Flash*)	flash_partition;;
		*)	echo "What??";;
		esac > /dev/tty
	fi
done