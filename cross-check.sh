# make sure toolchain is available
sudo apt-get install binutils gcc clang

# obtain TCC
wget http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2
tar -xvjf tcc-0.9.27.tar.bz2
cd tcc-0.9.27

# compile with GCC
./configure --cc=gcc --prefix=/tmp/gcc-tcc && make -j$(nproc) && make install
make clean && make distclean

# compile with Clang
./configure --cc=clang --prefix=/tmp/clang-tcc && make -j$(nproc) && make install
make clean && make distclean

# compile with GCC-TCC
./configure --cc=/tmp/gcc-tcc/bin/tcc --prefix=/tmp/gcc-tcc-tcc && make -j$(nproc) && make install
make clean && make distclean

# compile with Clang-TCC
./configure --cc=/tmp/clang-tcc/bin/tcc --prefix=/tmp/clang-tcc-tcc && make -j$(nproc) && make install
make clean && make distclean

# Generate SHA256 digests
openssl dgst -sha256 `find /tmp -type f -perm -111 -name "tcc"`

