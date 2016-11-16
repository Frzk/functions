#!/bin/bash

# ------------------------------------------------------------------------------
# Function wipe_disk
#
# Erases a whole disk, writing random data to the media. Once done, writes zeros to the disk.
#
# WARNING: USE WITH ULTIMATE CAUTION.
#
#
# Parameters
# ==========
# device (Req) :
#     Device identifier. Can be either :
#       * A device node entry (e.g. /dev/sdb)
#       * A volume mount point (e.g. /Volumes/MyDisk)
#
# times (Opt) :
#     Number of random passes before zeroing the device.
#     If omitted, defaults to `1`.
#
#
# Examples
# ========
# Erases the given disk, writing 5 times random data on it, then fullfills the disk with zeros.
#
#   wipe_disk /dev/sdc 5
#
# ------------------------------------------------------------------------------

function wipe_disk()
{
#Usage
read -r -d '' usage <<-'END_USAGE'
usage: wipe_disk device [times]
END_USAGE


    local t=1
    local blocksize=4096

    # Checks
    [[ $# -lt 1 ]] && { printf "%s\n" "${usage}"; return 1; }

    # Read parameters :
    local device="${1}"
    shift

    [[ "$#" -gt 0 ]] && [[ $1 =~ ^[0-9]+$ ]] && { t="${1}"; }

    # Job
    for (( n=1; n<=${t}; n++ ))
    do
        printf "Random pass %s/%s\n" "${n}" "${t}"
        sync
        dd if=/dev/urandom of="${device}" bs="${blocksize}" conv=noerror,notrunc
    done

    printf "Zero pass\n"
    sync
    dd if=/dev/zero of="${device}" bs="${blocksize}" conv=noerror,notrunc
}

readonly -f wipe_disk

#EOF
