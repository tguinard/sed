#!/bin/sed -nf
#sum integers (positive or negative).  Input: one line per integer

#represent a digit, n, as xa**n
#b = negative digit
s/[^0-9-]//g
s/0/x/g
s/1/xa/g
s/2/xaa/g
s/3/xaaa/g
s/4/xaaaa/g
s/5/xaaaaa/g
s/6/xaaaaaa/g
s/7/xaaaaaaa/g
s/8/xaaaaaaaa/g
s/9/xaaaaaaaaa/g
/^-/ s/a/b/g
s/-//g

#add things without worrying about carrying
G
s/$/\n/
:a
/^\n\n/{
    bb
}
s/x\([ab]*\)\(\n.*\)x\([ab]*\)\n/\2\nx\1\3/
s/x\([ab]*\)\n\n/\n\nx\1/
s/^\n\(.*\)x\([ab]*\)\n/\n\1\nx\2/
ba
:b
s/\n\n//

#simplify: make result have all a's or all b's, less than 10 a's or b's in a row
:c
/ba/{
    s/ba//g
    bc
}
/ab/{
    s/ab//g
    bc
}

/axb/{
    s/axb/xaaaaaaaaa/g
    bc
}

/bxa/{
    s/bxa/xbbbbbbbbb/g
    bc
}

/xaaaaaaaaaa/{
    s/xaaaaaaaaaa/ax/g
    s/^a/xa/
    bc
}

/xbbbbbbbbbb/{
    s/xbbbbbbbbbb/bx/g
    s/^b/xb/
    bc
}

#get rid of all leading zeros
s/^x*x/x/

h

#print out in readable format at EOF
${
    /b/ {
        s/b/a/g
        s/^/-/
    }
    s/xaaaaaaaaa/9/g
    s/xaaaaaaaa/8/g
    s/xaaaaaaa/7/g
    s/xaaaaaa/6/g
    s/xaaaaa/5/g
    s/xaaaa/4/g
    s/xaaa/3/g
    s/xaa/2/g
    s/xa/1/g
    s/x/0/g
    p
}
