#!/usr/bin/bash
clear
trap 'exit 0' INT
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
# "${NONE}"
# "${RED}"
# "${GREEN}"
# "${YELLOW}"
# "${PURPLE}"
# "${CYAN}"
# "${WHITE}"
# "${BOLD}"
# "${UNDERLINE}"

# Progressbar Function
progress() {
prog() {
    local w=50 p=$1;  shift
    # create a string of spaces, then change them to dots
    printf -v dots "%*s" "$(( $p*$w/100 ))" ""; dots=${dots// /.};
    # print those dots on a fixed-width space plus the percentage etc.
    printf "\r\e[K|%-*s| %3d %% %s" "$w" "$dots" "$p" "$*";
}
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""

# test loop
for x in {1..100} ; do
    prog "$x" THIS SCRIPT WILL HELP YOU UPDATE YOUR OLD PASSWORD WITH NEW ONE ...
    sleep .02   # do some work here
done ; echo

}
progress

# Users list
all_users="$( fdesetup list | cut -d, -f1,1 )"
i=1
for u in ${all_users[@]}
	do
	 a=$(( i++ ))
	 sleep .2
	 echo ""$a".) "${PURPLE}"  "${BOLD}"  "$u"" "${NONE}"
	done
sleep 2
echo	"${GREEN}"
	 read -p "GIVE THE USER NAME FOR PASSWORD UPDATE: " usr
echo 	"${NONE}"
echo ""

# IN $drive VAR IS SAVED THE DISK IDENTIFIER
drive="$( diskutil list | grep "Macintosh HD" | awk '{print $8}'  )"

# SELECT USER UID
user_uid="$( fdesetup list | grep "$usr" | cut -d, -f2-  )"

# ARE YOU SURE YOU WANT TO ?
sleep 2
	echo 	"${RED}"
	read -p "ARE YOU SURE THAT YOU WANT TO CHANGE THE PASSWPRD FOR --->>>  "$usr"  <<<--- AND ALSO YOU MASCHINE WILL BE AUTOMATICALLY RESET. CONTINUE  ? Y/N : " answer
	answer="$(echo $answer | tr '[:upper:]' '[:lower:] ' | cut -c1)"
	echo 	"${NONE}"
# IF ANSWER IS OTHER THAN YES
	if [ "$answer" != "y" ] ; then
	 echo ""
	 echo	"${BOLD}"
	 echo    " MAYBY NEXT TIME ?"
	 echo 	"${NONE}"
	 sleep 2
	else
	sudo diskutil apfs changePassphrase "$drive" -user "$user_uid"
sleep 5
	clear
	echo ""
echo ""
echo ""
echo ""
echo ""
	echo "${RED}"  "                            ITS GONNA BE LITTLE CREEPY NOW " "${NONE}"
	sleep 4
	
	# PREBOOT UPDATE AFTER PASSWORD CHANGE	
	sudo diskutil apfs updatePreboot /
	sleep 2
	clear
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo "${RED}"  "                            EVERYTHING FINE NOW. FROM NOW YOU CAN USE YOUR NEW PASSWORD EVERYWHERE ! " "${NONE}"
	sleep 5
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
# SECOND PROGRESS BAR
progress2() {
# progress bar function
	prog() {
   		 local w=50 p=$1;  shift
    # create a string of spaces, then change them to dots
    		printf -v dots "%*s" "$(( $p*$w/100 ))" ""; dots=${dots// /.};
    # print those dots on a fixed-width space plus the percentage etc.
    		printf "\r\e[K|%-*s| %3d %% %s" "$w" "$dots" "$p" "$*";
}
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
# test loop
for x in {1..100} ; do
    prog "$x" YOUR COMPUTER WILL RESET IN A FEW SECONDS ...
    sleep .04   # do some work here
done ; echo
}
progress2
sleep 2
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""

echo "                                                              BYE BYE " 
reboot
fi
