#!/bin/bash

# ------------------------------------------------------------------------------
# Function osx_uninstall_package
#
# Removes files and directories created by the given package.
# Uses pkgutil to get a list of files and directories created during the
# installation of the given package and removes them.
#
# If one or more .plist files are given, uses launchctl to unload them.
# This is especially useful when the package came with an updater daemon or
# things like that.
#
# WARNING: USE AT YOUR OWN RISKS !
#
# Parameters
# ==========
# pkg (Req) :
#     Name of the package to remove.
#
# *args (Opt) :
#     .plist files to unload.
#
# Examples
# ========
# 
#     pkg = "com.adobe.pkg.FlashPlayer"
#     plist = "/Library/LaunchDaemons/com.adobe.fpsaud.plist"
#     
#     osx_uninstall_package "${pkg}" "${plist}"
#
# ------------------------------------------------------------------------------

function osx_uninstall_package()
{
#Usage
read -r -d '' usage <<-'END_USAGE'
usage: osx_uninstall package_name plist1 plist2 plist3 ...
END_USAGE


    local pkg

    # Checks
    [[ $# -lt 1 ]] && { printf "%s\n" "${usage}"; return 1; }


    pkg="${1}"

    shift

    # Unload plists if any:
    for plist in "${@}"
    do
        launchctl unload "${plist}"
    done

    # Retrieve root path for files of the package:
    vol=$(pkgutil --pkg-info "${pkg}" \
            | grep "volume" \
            | cut -d ":" -f 2 \
            | tr -d " ")

    # Remove files:
    while IFS= read -r f
    do
        rm "${vol}${f}"
    done < <(pkgutil --only-files --files "${pkg}")

    # Then remove directories (only if empty, so we don't remove needed dirs):
    while IFS= read -r d
    do
        rmdir "${vol}${d}"
    done < <(pkgutil --only-dirs --files "${pkg}" | tail -r)

    # Finally forget the package:
    pkgutil --forget "${pkg}"
}

readonly -f osx_uninstall_package

#EOF
