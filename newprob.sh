#!/bin/bash -e

NUMBER=$1

if [ -z "$NUMBER" ]; then
	echo "usage: $0 <problem#>"
	exit
fi

mkdir -p "$NUMBER"

if [ ! -f "$NUMBER/main.rb" ]; then
	cp "boiler.rb" "$NUMBER/main.rb"
fi


cd "$NUMBER"

