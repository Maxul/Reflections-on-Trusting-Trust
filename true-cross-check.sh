# Note: We must make sure the compiler paths and executable names are identical

# make sure toolchain is available
sudo apt-get install binutils gcc clang

# obtain TCC
wget http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2
tar -xvjf tcc-0.9.27.tar.bz2
cd tcc-0.9.27

# compile with GCC
./configure --cc=gcc --prefix=/tmp/tcc && make -j$(nproc) && make install
make clean && make distclean

# compile with GCC-TCC
./configure --cc=/tmp/tcc/bin/tcc && make -j$(nproc) && mv tcc ../gcc-tcc
make clean && make distclean

# clean GCC trace
rm /tmp/tcc

# compile with Clang
./configure --cc=clang --prefix=/tmp/tcc && make -j$(nproc) && make install
make clean && make distclean

# compile with Clang-TCC
./configure --cc=/tmp/tcc/bin/tcc && make -j$(nproc) && mv tcc ../clang-tcc
make clean && make distclean

cd ..

# Generate SHA256 digests
openssl dgst -sha256 `find . -type f -perm -111 -name "*tcc*"`

