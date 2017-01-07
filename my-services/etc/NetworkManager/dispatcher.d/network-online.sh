#!/bin/bash

if /usr/bin/nm-online --timeout 3; then
  /bin/systemctl start network-online.target
else
  /bin/systemctl stop network-online.target
fi

exit 0

