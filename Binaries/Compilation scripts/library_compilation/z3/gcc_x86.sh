function do_gcc_x86() {
  if [ ! -d "./builds/x86-gcc-$1-O$2" ]
  then
    unset CROSS_COMPILE
    unset AS
    unset LD
    unset AR
    unset RANLIB
    unset NM

    export CC=gcc-$1
    export CXX=g++-$1
    export CFLAGS="-g -fno-inline-functions -m32 -O$2   -I/usr/i686-linux-gnu/include/ "
    export CXXFLAGS="-g -fno-inline-functions -m32 -O$2   -I/usr/i686-linux-gnu/include/ "
    export CPPFLAGS="-g -fno-inline-functions -m32 -O$2   -I/usr/i686-linux-gnu/include/ "
    unset LDFLAGS


    rm -rf build
    ./configure --x86 --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/x86-gcc-$1-O$2
    mkdir ./builds/x86-gcc-$1-O$2
    cp ./build/z3 ./builds/x86-gcc-$1-O$2/z3
    cp ./build/libz3.so ./builds/x86-gcc-$1-O$2/libz3.so
  fi
}

do_gcc_x86 $1 $2