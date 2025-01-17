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
  unset CROSS_COMPILE
  unset AS
  unset LD
  unset AR
  unset RANLIB
  unset NM
  unset LIBS
  unset LDFLAGS
  export CC=gcc-$1
  export CXX=g++-$1
  export CFLAGS="-g -fno-inline-functions -m32 -O$2   -I/usr/i686-linux-gnu/include/"
  export CXXFLAGS="-g -fno-inline-functions -m32 -O$2   -I/usr/i686-linux-gnu/include/"
  export LDFLAGS="-g -pthread -fno-inline-functions -m32 -O$2 -Wl,-z,notext -I/usr/i686-linux-gnu/include/"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make

  rm -rf ./builds/x86-gcc-$1-O$2
  mkdir ./builds/x86-gcc-$1-O$2
  cp ./unrar    ./builds/x86-gcc-$1-O$2/unrar
}

function do_gcc_x64 {
  unset CROSS_COMPILE
  unset AS
  unset LD
  unset AR
  unset RANLIB
  unset NM
  unset LIBS
  unset LDFLAGS
  export CC=gcc-$1
  export CXX=g++-$1
  export CFLAGS="-g -fno-inline-functions -m64 -O$2 -g"
  export CXXFLAGS="-g -fno-inline-functions -m64 -O$2 -g"
  export LDFLAGS="-pthread -fno-inline-functions -m64 -O$2 -Wl,-z,notext"
  export LIBS="-libverbs"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make


  rm -rf ./builds/x64-gcc-$1-O$2
  mkdir ./builds/x64-gcc-$1-O$2
  cp ./unrar    ./builds/x64-gcc-$1-O$2/unrar
}

# $1 -> clang version
# $2 -> optimization
function do_clang_x86 {
  unset CROSS_COMPILE
  unset AS
  unset LD
  unset AR
  unset RANLIB
  unset NM
  unset LIBS
  unset LDFLAGS
  export CC=clang-$1
  export CXX=clang++-$1
  export CFLAGS="-g -fno-inline-functions -m32 -O$2   -I/usr/i686-linux-gnu/include/"
  export CXXFLAGS="-g -fno-inline-functions -m32 -O$2   -I/usr/i686-linux-gnu/include/"
  export LDFLAGS="-g -pthread -fno-inline-functions -m32 -O$2 -Wl,-z,notext -I/usr/i686-linux-gnu/include/"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make

  rm -rf ./builds/x86-clang-$1-O$2
  mkdir ./builds/x86-clang-$1-O$2
  cp ./unrar    ./builds/x86-clang-$1-O$2/unrar
}

# $1 -> clang version
# $2 -> optimization
function do_clang_x64 {
  unset CROSS_COMPILE
  unset AS
  unset LD
  unset AR
  unset RANLIB
  unset NM
  unset LIBS
  unset LDFLAGS
  export CC=clang-$1
  export CXX=clang++-$1
  export CFLAGS="-g -fno-inline-functions -m64 -O$2"
  export CXXFLAGS="-g -fno-inline-functions -m64 -O$2"
  export LDFLAGS="-pthread -fno-inline-functions -m64 -O$2 -Wl,-z,notext"
  export LIBS="-libverbs"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make

  rm -rf ./builds/x64-clang-$1-O$2
  mkdir ./builds/x64-clang-$1-O$2
  cp ./unrar    ./builds/x64-clang-$1-O$2/unrar
}

function do_gcc_arm_32 {
  unset LIBS
  unset LDFLAGS
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
  export LDFLAGS="-pthread"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make

  rm -rf ./builds/arm32-gcc-$1-O$2
  mkdir ./builds/arm32-gcc-$1-O$2
  cp ./unrar    ./builds/arm32-gcc-$1-O$2/unrar
}

function do_gcc_arm_48_32 {
  unset LIBS
  unset LDFLAGS
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
  export LDFLAGS="-pthread"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make

  rm -rf ./builds/arm32-gcc-$1-O$2
  mkdir ./builds/arm32-gcc-$1-O$2
  cp ./unrar    ./builds/arm32-gcc-$1-O$2/unrar
}

function do_gcc_arm_64 {
  unset LIBS
  unset LDFLAGS
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
  export LDFLAGS="-pthread"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make

  rm -rf ./builds/arm64-gcc-$1-O$2
  mkdir ./builds/arm64-gcc-$1-O$2
  cp ./unrar   ./builds/arm64-gcc-$1-O$2/unrar
}


function do_clang_arm_32 {
  unset CROSS_COMPILE
  unset AS
  unset LD
  unset AR
  unset RANLIB
  unset NM
  unset LIBS
  unset LDFLAGS
  export CROSS_COMPILE="arm-linux-gnueabi"
  export CC=clang-$1
  export CXX=clang++-$1
  export CFLAGS="-g -fno-inline-functions -fuse-ld=lld --target=arm-linux-gnu -march=armv8 -mfloat-abi=soft --sysroot=/usr/arm-linux-gnueabi -O$2 -Wl,-z,notext -I/usr/arm-linux-gnueabi/include/c++/7/ -I/usr/arm-linux-gnueabi/include/c++/7/arm-linux-gnueabi/"
  export CXXFLAGS="-g -fno-inline-functions -fuse-ld=lld --target=arm-linux-gnu -march=armv8 -mfloat-abi=soft --sysroot=/usr/arm-linux-gnueabi -O$2 -Wl,-z,notext -I/usr/arm-linux-gnueabi/include/c++/7/ -I/usr/arm-linux-gnueabi/include/c++/7/arm-linux-gnueabi/"
  # Due to the following error, -Wl,-z,notext needs to be added
  # ld.lld: error: can't create dynamic relocation R_MIPS_32 against local symbol in readonly segment; recompile object files with -fPIC or pass '-Wl,-z,notext' to allow text relocations in the output
  export LDFLAGS="-pthread -fuse-ld=lld --target=arm-linux-gnu --sysroot=/usr/arm-linux-gnueabi -L/usr/arm-linux-gnueabi/lib"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make

  rm -rf ./builds/arm32-clang-$1-O$2
  mkdir ./builds/arm32-clang-$1-O$2
  cp ./unrar    ./builds/arm32-clang-$1-O$2/unrar
}

function do_clang_arm_64 {
  unset CROSS_COMPILE
  unset AS
  unset LD
  unset AR
  unset RANLIB
  unset NM
  unset LIBS
  unset LDFLAGS
  export CROSS_COMPILE="aarch64-linux-gnu"
  export CC=clang-$1
  export CXX=clang++-$1
  # -march=armv8 we remove armv8, not detected, and aarch64 is armv8 in any case
  export CFLAGS="-g -fno-inline-functions -fuse-ld=lld --target=aarch64-linux-gnu  -mfloat-abi=soft --sysroot=/usr/aarch64-linux-gnu -O$2 -Wl,-z,notext -I/usr/aarch64-linux-gnu/include/c++/7/ -I/usr/aarch64-linux-gnu/include/c++/7/aarch64-linux-gnu/"
  export CXXFLAGS="-g -fno-inline-functions -fuse-ld=lld --target=aarch64-linux-gnu  -mfloat-abi=soft --sysroot=/usr/aarch64-linux-gnu -O$2 -Wl,-z,notext -I/usr/aarch64-linux-gnu/include/c++/7/ -I/usr/aarch64-linux-gnu/include/c++/7/aarch64-linux-gnu/"
  # Due to the following error, -Wl,-z,notext needs to be added
  # ld.lld: error: can't create dynamic relocation R_MIPS_32 against local symbol in readonly segment; recompile object files with -fPIC or pass '-Wl,-z,notext' to allow text relocations in the output
  export LDFLAGS="-pthread -fuse-ld=lld --target=aarch64-linux-gnu --sysroot=/usr/aarch64-linux-gnu"
  export DEFINES=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DRAR_SMP
  export LIBFLAGS=-fPIC

  make clean
  make

  rm -rf ./builds/arm64-clang-$1-O$2
  mkdir ./builds/arm64-clang-$1-O$2
  cp ./unrar    ./builds/arm64-clang-$1-O$2/unrar
}

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
for clang_v in 3.5 5.0  7 9 
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


# ARM64 CLANG
for clang_v in 3.5 5.0 7 9  
do
    for opt_level in 0 1 2 3 s
    do
        do_clang_arm_64 $clang_v $opt_level
    done
done
