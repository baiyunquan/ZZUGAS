del %1.exe
del %1.lst
del %1.o
gcc -Wa,-alm -L -g -o %1 ./progs/%1.S ./lib/winio64.a  > ./progs/%1.lst
dir %1.*