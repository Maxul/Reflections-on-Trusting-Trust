# make sure toolchain is available
sudo apt-get install binutils gcc clang

# prepare
mkdir gcc-tcc clang-tcc gcc-tcc-tcc clang-tcc-tcc

# obtain TCC
wget http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2
tar -xvjf tcc-0.9.27.tar.bz2
cd tcc-0.9.27

# compile with GCC
./configure --cc=gcc && make
mv tcc libtcc1.a libtcc.a ../gcc-tcc
make clean && make distclean

# compile with Clang
./configure --cc=clang && make
mv tcc libtcc1.a libtcc.a ../clang-tcc
make clean && make distclean

# compile with GCC-TCC
./configure --cc=../gcc-tcc/tcc && make
mv tcc libtcc1.a libtcc.a ../gcc-tcc-tcc
make clean && make distclean

# compile with Clang-TCC
./configure --cc=../clang-tcc/tcc && make
mv tcc libtcc1.a libtcc.a ../clang-tcc-tcc
make clean && make distclean

cd ..

# Generate SHA256 digests
openssl dgst -sha256 gcc-tcc-tcc/*
openssl dgst -sha256 clang-tcc-tcc/*
