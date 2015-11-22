#!/bin/bash

# Usage: install_from <manifest>
# Creates symlinks from the home directory to files listed in <manifest>
# If any of these files already exists, it will be moved to /tmp
install_from() {
    for file in $(cat $1);
    do
	homefile="${HOME}/${file}"
	file="$(pwd)/${file}"
	test -e ${homefile} && mv ${homefile} /tmp
	ln -s ${file} ${homefile} && echo "linked ${homefile} -> ${file}"
    done
}

install_from include.txt
