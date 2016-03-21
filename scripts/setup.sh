#!/bin/bash

hello() {
	echo "hello"
}

exists() {
	type "$1" > /dev/null 2>&1;
}

export -f hello
export -f exists

