#!/bin/bash

# ------------------------------------------------------------------------------
# Function someone_is_logged_in
#
# Checks if someone has an open session.
#
#
# Example
# =======
# Shutdown computer if noone is logged in :
#
#     [[ ! someone_is_logged_in ]] && shutdown -h now
#
# ------------------------------------------------------------------------------

function someone_is_logged_in()
{
    return $(who | grep -q "console")
}


# ------------------------------------------------------------------------------
# Function logged_in_users
#
# Returns a list of currently logged in users.
#
#
# Example
# =======
# Do something for each logged in user :
#
#     while IFS= read -r user
#     do
#        # Do something meaningful here.
#        printf "%s\n" "${user}"
#     done < <(logged_in_users)"
#
# ------------------------------------------------------------------------------

function logged_in_users()
{
    printf "%s\n" "$(who | grep 'console' | cut -d' ' -f1)"
}



readonly -f someone_is_logged_in
readonly -f logged_in_users

#EOF
