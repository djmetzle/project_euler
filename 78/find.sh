gcc a000041.c -lgmp
echo `./a.out | grep -E '000000$'`
