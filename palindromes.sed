#!/bin/sed -f
h
s/$/\n/g
:a
s/\(.*\)\(.\)\n\(.*\)/\1\n\3\2/
/.\n/ ba
s/\n//
G
s/^\(.*\)\n\1$/\1/
/\n/d