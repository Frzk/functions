functions
=========
(OSX) A bunch of reusable (and helpful ?) Bash functions.

---

The goal is to provide a set of reusable functions for your shellscripts.

I'll try to keep them portable, but I'm mostly targetting OSX for now.


How to use
----------
It's pretty simple !

Either download the files as zip, or `git clone` this repository.

Open your favorite text editor and use `source` to import what you need.

Example :

```bash
#!/bin/bash

# import the needed functions :

source "/path/to/functions/iAmRoot.sh"
source "/path/to/functions/forAllSubdirs.sh"

# and do whatever you want with them :

iAmRoot || { printf "%s\n" "You have to be root to run this. Aborting."; exit 1; }

forAllSubdirs "/" "ls -al"

exit 0
```
