echo "assembling for linux" &&
as -o hello_linux.o hello_linux.s &&
ld -o hello_linux hello_linux.o -e _start &&

echo "assembling for windows" &&
x86_64-w64-mingw32-as -o hello_win.o hello_win.asm &&
x86_64-w64-mingw32-ld -o hello_win.exe hello_win.o -e _start -lkernel32 &&

rm hello_linux.o hello_win.o

echo
echo "running linux"
./hello_linux