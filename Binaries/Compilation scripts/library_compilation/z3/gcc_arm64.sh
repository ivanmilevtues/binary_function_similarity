function do_gcc_arm_64() (
  if [ ! -d "./builds/arm64-gcc-$1-O$2" ]
  then
    export CROSS_COMPILE="aarch64-linux-gnu"
    export AR=${CROSS_COMPILE}-ar
    export AS=${CROSS_COMPILE}-as
    export LD=${CROSS_COMPILE}-ld
    export RANLIB=${CROSS_COMPILE}-ranlib
    export CC=${CROSS_COMPILE}-gcc-$1
    export NM=${CROSS_COMPILE}-nm
    export CFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
    export CXX=${CROSS_COMPILE}-g++-$1
    export CXXFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
    export LDFLAGS="-L/usr/aarch64-linux-gnu/lib/  -Wl,-z,notext"

    rm -rf build
    ./configure --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/arm64-gcc-$1-O$2
    mkdir ./builds/arm64-gcc-$1-O$2
    cp ./build/z3 ./builds/arm64-gcc-$1-O$2/z3
    cp ./build/libz3.so ./builds/arm64-gcc-$1-O$2/libz3.so
  fi
)

echo $1 $2
do_gcc_arm_64 $1 $2