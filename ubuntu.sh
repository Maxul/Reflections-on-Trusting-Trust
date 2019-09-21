# make sure toolchain is available
sudo apt-get install binutils gcc clang

# prepare
mkdir gcc-tcc clang-tcc gcc-tcc-tcc clang-tcc-tcc

# obtain TCC
wget http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2
tar -xvjf tcc-0.9.27.tar.bz2
cd tcc-0.9.27

# compile the default and install
./configure && make -j$(nproc) && sudo make install

# compile with GCC
./configure --cc=gcc && make -j$(nproc)
mv tcc ../gcc-tcc
make clean && make distclean

# compile with Clang
./configure --cc=clang && make -j$(nproc)
mv tcc ../clang-tcc
make clean && make distclean

# compile with GCC-TCC
./configure --cc=../gcc-tcc/tcc && make -j$(nproc)
mv tcc ../gcc-tcc-tcc
make clean && make distclean

# compile with Clang-TCC
./configure --cc=../clang-tcc/tcc && make -j$(nproc)
mv tcc ../clang-tcc-tcc
make clean && make distclean

cd ..

# uninstall the default
cd tcc-0.9.27
./configure && make -j$(nproc) && sudo make uninstall

# Generate SHA256 digests
openssl dgst -sha256 `find . -name "tcc"`
