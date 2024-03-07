function do_clang_arm_32() (
  if [ ! -d "./builds/arm32-clang-$1-O$2" ]
  then
    unset CROSS_COMPILE
    unset AS
    unset LD
    unset AR
    unset RANLIB
    unset NM
    export CC=clang-$1
    export CXX=clang++-$1
    export CFLAGS="-g -fno-inline-functions  --target=arm-linux-gnu -march=armv8  -O$2 -I/usr/arm-linux-gnueabi/include/c++/7/ -I/usr/arm-linux-gnueabi/include/c++/7/arm-linux-gnueabi/  -I/usr/arm-linux-gnueabi/include/"
    export CXXFLAGS=$CFLAGS
    export CPPFLAGS=$CFLAGS
    export LDFLAGS="-fuse-ld=lld-8 --target=arm-linux-gnu  -L/usr/arm-linux-gnueabi/lib/  -Wl,-z,notext"

    rm -rf build
    ./configure --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/arm32-clang-$1-O$2
    mkdir ./builds/arm32-clang-$1-O$2
    cp ./build/z3 ./builds/arm32-clang-$1-O$2/z3
    cp ./build/libz3.so ./builds/arm32-clang-$1-O$2/libz3.so
  fi
)

echo $1 $2
do_clang_arm_32 $1 $2