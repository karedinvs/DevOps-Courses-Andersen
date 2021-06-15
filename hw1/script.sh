#!/bin/bash
IDNAMEPROC=$1

if [ -z "$IDNAMEPROC" ]; then
        echo "You forget use the arg. Script runs without it"
fi


#check whois status and install it
if ! command -v whois &> /dev/null
then
    echo "whois util not present on this PC"
    sudo apt update
    sudo apt install whois -y
fi

#check net-tools status and install it
if ! command -v netstat &> /dev/null
then
    echo "net-tools not present on this PC"
    sudo apt install net-tools -y
fi


PS3="Please choose state of socket you want will see: "
select CONNTYPE in ESTABLISHED LISTEN
do
    echo "You choose type: $CONNTYPE"
    echo "You chosse number: $REPLY"
    break
done

read -p "Enter the number of line you want to see after output: " LINEKEY




if  [ $(id -u) = 0 ]
then
        echo "----------------Run script with SUDO----------------------"
        if [ -z "$(sudo netstat -tunapl | grep -i "$CONNTYPE")" ]; then
                GETIPRES=$(sudo netstat -tunapl 2> /dev/null | grep -i "$CONNTYPE" | awk '/'$IDNAMEPROC'/ {print $5}' | cut -d: -f1 | uniq -c | sort | tail -n$LINEKEY | grep -oP '(\d+\.){3}\d+')
        else
                GETIPRES=$(sudo netstat -tunapl 2> /dev/null | awk '/'$IDNAMEPROC'/ {print $5}' | cut -d: -f1 | uniq -c | sort | tail -n$LINEKEY | grep -oP '(\d+\.){3}\d+')
        fi



while read IP; do
                RESULTORG=$(whois $IP | awk -F':' '/^Organization/ {print $2}')
                RESULTCIDR=$(whois $IP | awk -F':' '/^CIDR/ {print $2}')
                RESIP="$(echo $IP | awk '{printf(" (IP: %s)", $1)}')"

                if [[ ! -z "$RESULTORG" && ! -z "$RESIP" ]]; then
                        echo -e "Organization: $RESULTORG $RESIP CIDR: $RESULTCIDR"
                elif [[ ! -z "$RESIP" ]]; then
                        echo -e "Organization not found: $RESIP"
                fi

done <<< "$GETIPRES"


else
         echo "----------------Run script without SUDO----------------------"
         if [ ! -z "$(netstat -tunapl | grep -i "$CONNTYPE")" ]; then
                GETIPRES=$(netstat -tunapl 2> /dev/null | grep -i "$CONNTYPE" | awk '/'$IDNAMEPROC'/ {print $5}' | cut -d: -f1 | uniq -c | sort | tail -n$LINEKEY | grep -oP '(\d+\.){3}\d+')
         else
                GETIPRES=$(netstat -tunapl 2> /dev/null | awk '/'$IDNAMEPROC'/ {print $5}' | cut -d: -f1 | uniq -c | sort | tail -n$LINEKEY | grep -oP '(\d+\.){3}\d+')
         fi



while read IP; do
                 RESULTORG=$(whois $IP | awk -F':' '/^Organization/ {print $2}')
                 RESULTCIDR=$(whois $IP | awk -F':' '/^CIDR/ {print $2}')
                 RESIP="$(echo $IP | awk '{printf(" (IP: %s)", $1)}')"

                if [[ ! -z "$RESULTORG" && ! -z "$RESIP" ]]; then
                        echo -e "Organization: $RESULTORG $RESIP CIDR: ${RESULTCIDR}"
                elif [[ ! -z "$RESIP" ]]; then
                        echo -e "Organization not found: $RESIP"
                fi

done <<< "$GETIPRES"

fi
