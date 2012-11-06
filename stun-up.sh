#!/bin/sh
# Script to launch stund on an aws instance.

# First, get a list of our IP addresses.
API_ROOT=http://169.254.169.254/latest/meta-data/network/interfaces/macs/
MACS=$(curl -s ${API_ROOT})
for mac in ${MACS}; do
  ADDRS="$ADDRS $(curl -s ${API_ROOT}${mac}/local-ipv4s)"
  #ADDRS="$ADDRS $(curl -s ${API_ROOT}${mac}/public-ipv4s)"
done
if [ $(echo ${ADDRS} | wc -w) -lt 2 ]; then
  echo "Need at least two IP addresses"
    exit 1
  fi

# Now, launch the daemon.
set -- ${ADDRS}
echo "/usr/sbin/stund -h $1 -a $2 > /dev/null 2>&1"
