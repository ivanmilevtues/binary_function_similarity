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
function do_gcc_x86 {
  export CC=gcc-$1
  export CXX=g++-$1
  export CFLAGS="-g -fno-inline-functions -m32 -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/x86-gcc-$1-O$2
  mkdir ./builds/x86-gcc-$1-O$2
  cp ./libz.so.1.2.11 ./builds/x86-gcc-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/x86-gcc-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/x86-gcc-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/x86-gcc-$1-O$2/minigzip64
}

function do_gcc_x64 {
  export CC=gcc-$1
  export CXX=g++-$1
  export CFLAGS="-g -fno-inline-functions -m64 -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/x64-gcc-$1-O$2
  mkdir ./builds/x64-gcc-$1-O$2
  cp ./libz.so.1.2.11 ./builds/x64-gcc-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/x64-gcc-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/x64-gcc-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/x64-gcc-$1-O$2/minigzip64
}

# $1 -> clang version
# $2 -> optimization
function do_clang_x86 {
  export CC=clang-$1
  export CXX=clang++-$1
  export CFLAGS="-g -fno-inline-functions -m32 -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/x86-clang-$1-O$2
  mkdir ./builds/x86-clang-$1-O$2
  cp ./libz.so.1.2.11 ./builds/x86-clang-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/x86-clang-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/x86-clang-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/x86-clang-$1-O$2/minigzip64
}

# $1 -> clang version
# $2 -> optimization
function do_clang_x64 {
  export CC=clang-$1
  export CXX=clang++-$1
  export CFLAGS="-g -fno-inline-functions -m64 -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/x64-clang-$1-O$2
  mkdir ./builds/x64-clang-$1-O$2
  cp ./libz.so.1.2.11 ./builds/x64-clang-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/x64-clang-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/x64-clang-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/x64-clang-$1-O$2/minigzip64
}

function do_gcc_arm_32 {
  export CROSS_COMPILE="arm-linux-gnueabi"
  export CHOST=${CROSS_COMPILE}
  export CC=${CROSS_COMPILE}-gcc-$1
  export CFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/arm32-gcc-$1-O$2
  mkdir ./builds/arm32-gcc-$1-O$2
  cp ./libz.so.1.2.11 ./builds/arm32-gcc-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/arm32-gcc-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/arm32-gcc-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/arm32-gcc-$1-O$2/minigzip64
}

function do_gcc_arm_48_32 {
  export CROSS_COMPILE="arm-linux-gnueabi"
  export CHOST=${CROSS_COMPILE}
  export CC=/mnt/hgfs/first_training_dataset/gcc-4.8.5_arm/install_dir/bin/arm-linux-gnueabi-gcc-4.8.5
  export CFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/arm32-gcc-$1-O$2
  mkdir ./builds/arm32-gcc-$1-O$2
  cp ./libz.so.1.2.11 ./builds/arm32-gcc-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/arm32-gcc-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/arm32-gcc-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/arm32-gcc-$1-O$2/minigzip64
}

function do_gcc_arm_64 {
  export CROSS_COMPILE="aarch64-linux-gnu"
  export CHOST=${CROSS_COMPILE}
  export CC=${CROSS_COMPILE}-gcc-$1
  export CFLAGS="-g -fno-inline-functions -march=armv8-a -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/arm64-gcc-$1-O$2
  mkdir ./builds/arm64-gcc-$1-O$2
  cp ./libz.so.1.2.11 ./builds/arm64-gcc-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/arm64-gcc-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/arm64-gcc-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/arm64-gcc-$1-O$2/minigzip64
}

function do_clang_arm_32 {
  export CC=clang-$1
  export CXX=clang++-$1
  export CFLAGS="-g -fno-inline-functions -fuse-ld=lld --target=arm-linux-gnu -march=armv8 --sysroot=/usr/arm-linux-gnueabi -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/arm32-clang-$1-O$2
  mkdir ./builds/arm32-clang-$1-O$2
  cp ./libz.so.1.2.11 ./builds/arm32-clang-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/arm32-clang-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/arm32-clang-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/arm32-clang-$1-O$2/minigzip64
}

function do_clang_arm_64 {
  export CC=clang-$1
  export CXX=clang++-$1
  export CFLAGS="-g -fno-inline-functions -fuse-ld=lld --target=aarch64-linux-gnu -march=armv8 --sysroot=/usr/aarch64-linux-gnu -O$2"
  make distclean
  make clean
  ./configure
  make
  rm -rf ./builds/arm64-clang-$1-O$2
  mkdir ./builds/arm64-clang-$1-O$2
  cp ./libz.so.1.2.11 ./builds/arm64-clang-$1-O$2/libz.so.1.2.11
  cp ./minigzip       ./builds/arm64-clang-$1-O$2/minigzip
  cp ./minigzipsh     ./builds/arm64-clang-$1-O$2/minigzipsh
  cp ./minigzip64     ./builds/arm64-clang-$1-O$2/minigzip64
}

# ARM32 CLANG
for clang_v in 3.5 5.0 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_clang_arm_32 $clang_v $opt_level
    done
done

# ARM64 CLANG
for clang_v in 3.5 5.0 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_clang_arm_64 $clang_v $opt_level
    done
done

# x86-64 GCC
for gcc_v in 4.8 5 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_gcc_x86 $gcc_v $opt_level
    done
done

# x86-64 GCC
for gcc_v in 4.8 5 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_gcc_x64 $gcc_v $opt_level
    done
done

# x86-64 CLANG
for clang_v in 3.5 5.0 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_clang_x86 $clang_v $opt_level
    done
done

# x86-64 CLANG
for clang_v in 3.5 5.0 7 9
do
    for opt_level in 0 1 2 3 s
    do
        do_clang_x64 $clang_v $opt_level
    done
done

# GCC ARM32 // 4.8 must be done differently
for opt_level in 0 1 2 3 s
do
    do_gcc_arm_48_32 4.8 $opt_level
done

# GCC ARM32 // 9 must be done on 19.10, 4.8 must be done differently 
for gcc_v in  5 7
do
    for opt_level in 0 1 2 3 s
    do
        do_gcc_arm_32 $gcc_v $opt_level
    done
done

# GCC ARM64 // 9 must be done on 19.10 
for gcc_v in 4.8 5 7
do
    for opt_level in 0 1 2 3 s
    do
        do_gcc_arm_64 $gcc_v $opt_level
    done
done

