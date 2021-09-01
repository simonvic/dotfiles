#!/bin/bash

case $(sBatteryctl wakelock status) in
on) echo " " ;;
# off) echo "﯈" ;;
esac
