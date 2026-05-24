gcc -c ZZUGAS/lib/io_linux64_impl.c -o ZZUGAS/lib/io_linux64_impl.o -O2 -Wall -Wextra
gcc -c ZZUGAS/lib/io_linux64_wrappers.S -o ZZUGAS/lib/io_linux64_wrappers.o -Wall
ar rcs ZZUGAS/lib/io_linux64.a ZZUGAS/lib/io_linux64_impl.o ZZUGAS/lib/io_linux64_wrappers.o
gcc -o ZZUGAS/tests/io_linux64_test_all ZZUGAS/tests/io_linux64_test_all.S ZZUGAS/lib/io_linux64.a
./ZZUGAS/tests/io_linux64_test_all < ZZUGAS/tests/io_linux64_test_input.txt > ZZUGAS/tests/io_linux64_actual_output.txt
diff -u ZZUGAS/tests/io_linux64_expected_output.txt ZZUGAS/tests/io_linux64_actual_output.txt