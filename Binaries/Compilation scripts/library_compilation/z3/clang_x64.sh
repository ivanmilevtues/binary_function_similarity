function do_clang_x64() {
  if [ ! -d "./builds/x64-clang-$1-O$2" ]
  then
    unset CROSS_COMPILE
    unset AS
    unset LD
    unset AR
    unset RANLIB
    unset NM
    export CC=clang-$1
    export CXX=clang++-$1
    export CFLAGS="-g -fno-inline-functions -m64 -O$2"
    export CXXFLAGS="-g -fno-inline-functions -m64 -O$2"
    unset LDFLAGS

    rm -rf build
    ./configure --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/x64-clang-$1-O$2
    mkdir ./builds/x64-clang-$1-O$2
    cp ./build/z3 ./builds/x64-clang-$1-O$2/z3
    cp ./build/libz3.so ./builds/x64-clang-$1-O$2/libz3.so
  fi
}

echo $1 $2
do_clang_x64 $1 $2