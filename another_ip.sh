#!/bin/bash

# dhclient configuration path
CONFIG="/etc/dhclient.conf";

# Provided interface
INTERFACE="$1";

# Count how many secondary interfaces we have, increment the counter by 1
NUM_PSEUDO="$(ip address show "$INTERFACE" secondary | grep secondary | wc -l)";
NEXT_PSEUDO=$(($NUM_PSEUDO + 1));

# Assemble interface name
PSEUDO_INTERFACE="$INTERFACE:$NEXT_PSEUDO";

# Check if it's already in the config file
if grep -Fxq "$PSEUDO_INTERFACE" "$CONFIG"
then
    echo "Already in config! Skipping...";
else
    echo "
pseudo \"$PSEUDO_INTERFACE\" \"$INTERFACE\" {
    send dhcp-client-identifier \"additional_$INTERFACE_$NEXT_PSEUDO\";
}
" >> "$CONFIG";
fi

# Ask dhcp to give us an IP for new interface (it gets automaticly created)
dhclient -v "$PSEUDO_INTERFACE";
