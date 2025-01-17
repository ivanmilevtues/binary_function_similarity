#!/bin/bash
##############################################################################
#                                                                            #
#  Code for the USENIX Security '22 paper:                                   #
#  How Machine Learning Is Solving the Binary Function Similarity Problem.   #
#                                                                            #
#  MIT License                                                               #
#                                                                            #
#  Copyright (c) 2019-2022 Cisco Talos                                       #
#                                                                            #
#  Permission is hereby granted, free of charge, to any person obtaining     #
#  a copy of this software and associated documentation files (the           #
#  "Software"), to deal in the Software without restriction, including       #
#  without limitation the rights to use, copy, modify, merge, publish,       #
#  distribute, sublicense, and/or sell copies of the Software, and to        #
#  permit persons to whom the Software is furnished to do so, subject to     #
#  the following conditions:                                                 #
#                                                                            #
#  The above copyright notice and this permission notice shall be            #
#  included in all copies or substantial portions of the Software.           #
#                                                                            #
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,           #
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF        #
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                     #
#  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE    #
#  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION    #
#  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION     #
#  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.           #
#                                                                            #
#  automate_all.sh - Automate library compilation                            #
#                                                                            #
##############################################################################

# $1 -> gcc version
# $2 -> optimization
function do_gcc_x86() (
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
)

function do_gcc_x64() (
  if [ ! -d "./builds/x64-gcc-$1-O$2" ]
  then
    unset CROSS_COMPILE
    unset AS
    unset LD
    unset AR
    unset RANLIB
    unset NM

    export CC=gcc-$1
    export CXX=g++-$1
    export CFLAGS="-g -fno-inline-functions -m64 -O$2"
    export CXXFLAGS="-g -fno-inline-functions -m64 -O$2"
    unset LDFLAGS


    rm -rf build
    ./configure --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/x64-gcc-$1-O$2
    mkdir ./builds/x64-gcc-$1-O$2
    cp ./build/z3 ./builds/x64-gcc-$1-O$2/z3
    cp ./build/libz3.so ./builds/x64-gcc-$1-O$2/libz3.so
  fi
)

# $1 -> clang version
# $2 -> optimization
function do_clang_x86() (
  if [ ! -d "./builds/x86-clang-$1-O$2" ]
  then
    unset CROSS_COMPILE
    unset AS
    unset LD
    unset AR
    unset RANLIB
    unset NM
    export CC=clang-$1
    export CXX=clang++-$1
    export CFLAGS="-g -fno-inline-functions -m32 -O$2  -I/usr/i686-linux-gnu/include/"
    export CXXFLAGS="-g -fno-inline-functions -m32 -O$2  -I/usr/i686-linux-gnu/include/ -std=c++11"
    export CPPFLAGS="-g -fno-inline-functions -m32 -O$2   -I/usr/i686-linux-gnu/include/ "
    unset LDFLAGS


    rm -rf build
    ./configure --x86 --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/x86-clang-$1-O$2
    mkdir ./builds/x86-clang-$1-O$2
    cp ./build/z3 ./builds/x86-clang-$1-O$2/z3
    cp ./build/libz3.so ./builds/x86-clang-$1-O$2/libz3.so
  fi
)

# $1 -> clang version
# $2 -> optimization
function do_clang_x64() (
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
)

function do_gcc_arm_32() (
  if [ ! -d "./builds/arm32-gcc-$1-O$2" ]
  then
    export CROSS_COMPILE="arm-linux-gnueabi"
    export AR=${CROSS_COMPILE}-ar
    export AS=${CROSS_COMPILE}-as
    export LD=${CROSS_COMPILE}-ld
    export RANLIB=${CROSS_COMPILE}-ranlib
    export CC=${CROSS_COMPILE}-gcc-$1
    export NM=${CROSS_COMPILE}-nm
    export CFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
    export CXX=${CROSS_COMPILE}-g++-$1
    export CXXFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
    export LDFLAGS="-L/usr/arm-linux-gnueabi/lib/  -Wl,-z,notext"

    rm -rf build
    ./configure --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/arm32-gcc-$1-O$2
    mkdir ./builds/arm32-gcc-$1-O$2
    cp ./build/z3 ./builds/arm32-gcc-$1-O$2/z3
    cp ./build/libz3.so ./builds/arm32-gcc-$1-O$2/libz3.so
  fi
)

function do_gcc_arm_48_32() (
  if [ ! -d "./builds/arm32-gcc-$1-O$2" ]
  then
    export CROSS_COMPILE="arm-linux-gnueabi"
    export AR=/mnt/hgfs/first_training_dataset/gcc-4.8.5_arm/install_dir/bin/arm-linux-gnueabi-ar
    export AS=/mnt/hgfs/first_training_dataset/gcc-4.8.5_arm/install_dir/bin/arm-linux-gnueabi-as
    export LD=/mnt/hgfs/first_training_dataset/gcc-4.8.5_arm/install_dir/bin/arm-linux-gnueabi-ld
    export RANLIB=/mnt/hgfs/first_training_dataset/gcc-4.8.5_arm/install_dir/bin/arm-linux-gnueabi-ranlib
    export CC=/mnt/hgfs/first_training_dataset/gcc-4.8.5_arm/install_dir/bin/arm-linux-gnueabi-gcc
    export NM=/mnt/hgfs/first_training_dataset/gcc-4.8.5_arm/install_dir/bin/arm-linux-gnueabi-nm
    export CFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
    export CXX=/mnt/hgfs/first_training_dataset/gcc-4.8.5_arm/install_dir/bin/arm-linux-gnueabi-g++
    export CXXFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
    export LDFLAGS="-L/usr/arm-linux-gnueabi/lib/  -Wl,-z,notext"

    rm -rf build
    ./configure --staticbin
    cd build
    make -j 16
    cd ..
    rm -rf ./builds/arm32-gcc-$1-O$2
    mkdir ./builds/arm32-gcc-$1-O$2
    cp ./build/z3 ./builds/arm32-gcc-$1-O$2/z3
    cp ./build/libz3.so ./builds/arm32-gcc-$1-O$2/libz3.so
  fi
)

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

# x86-64 GCC
for gcc_v in 4.8 5 7 9
do
    for opt_level in 2 3 s
    do
        do_gcc_x86 $gcc_v $opt_level
        wait
    done
done

# x86-64 GCC
for gcc_v in 4.8 5 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_gcc_x64 $gcc_v $opt_level
        wait
    done
done

# x86-64 CLANG
for clang_v in 3.5 5.0 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_clang_x86 $clang_v $opt_level
        wait
    done
done

# x86-64 CLANG
for clang_v in 3.5 5.0 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_clang_x64 $clang_v $opt_level
        wait
    done
done

# GCC ARM32 // 4.8 must be done differently
for opt_level in 0 1 2 3 s
do
    do_gcc_arm_48_32 4.8 $opt_level
    wait
done

# GCC ARM32 // 9 must be done on 19.10, 4.8 must be done differently 
for gcc_v in  5 7
do
    for opt_level in 0 1 2 3 s
    do
        do_gcc_arm_32 $gcc_v $opt_level
        wait
    done
done

# GCC ARM64 // 9 must be done on 19.10 
for gcc_v in 4.8 5 7
do
    for opt_level in 0 1 2 3 s
    do
        do_gcc_arm_64 $gcc_v $opt_level
        wait
    done
done

# ARM32 CLANG
for clang_v in 3.5 5.0 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_clang_arm_32 $clang_v $opt_level
        wait
    done
done

# ARM64 CLANG
# aarch64 fails (segfaults with clang 3.5, so we just discard it)
for clang_v in 3.5 5.0 7 9 
do
    for opt_level in 0 1 2 3 s
    do

        do_clang_arm_64 $clang_v $opt_level
        wait
    done
done
