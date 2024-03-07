function do_clang_arm_64() (
  if [ ! -d "./builds/arm64-clang-$1-O$2" ]
  then
    unset CROSS_COMPILE
    unset AS
    unset LD
    unset AR
    unset RANLIB
    unset NM
    export CC=clang-$1
    export CXX=clang++-$1
    # -march=armv8-a seems to give problems, we can remove it as aarch64 is armv8 already
    export CFLAGS="-g -fno-inline-functions --target=aarch64-linux-gnu   -O$2 -I/usr/aarch64-linux-gnu/include/c++/7/ -I/usr/aarch64-linux-gnu/include/c++/7/aarch64-linux-gnu/  -I/usr/aarch64-linux-gnu/include/"
    export CXXFLAGS=$CFLAGS
    export CPPFLAGS=$CFLAGS
    export LDFLAGS="-fuse-ld=lld-8 --target=aarch64-linux-gnu  -L/usr/aarch64-linux-gnu/lib/  -Wl,-z,notext"

    rm -rf build
    ./configure --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/arm64-clang-$1-O$2
    mkdir ./builds/arm64-clang-$1-O$2
    cp ./build/z3 ./builds/arm64-clang-$1-O$2/z3
    cp ./build/libz3.so ./builds/arm64-clang-$1-O$2/libz3.so
  fi
)

echo $1 $2
do_clang_arm_64 $1 $2