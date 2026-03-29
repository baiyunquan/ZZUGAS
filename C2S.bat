echo off
gcc  -S -Og -masm=intel -c -o ./progs/%1.S ./progs/%1.c 

echo on