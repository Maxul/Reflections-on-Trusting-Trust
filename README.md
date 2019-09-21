## Using Diverse Double-Compiling (DDC) to Counter "Trusting Trust"

### Prepare
```sh
# make sure toolchain is available
sudo apt-get install binutils gcc clang
# mkdir for 1st round
mkdir gcc-tcc clang-tcc
# mkidr for 2nd round
mkdir gcc-tcc-tcc clang-tcc-tcc
```

### Obtain TCC
```sh
wget http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2
tar -xvjf tcc-0.9.27.tar.bz2
cd tcc-0.9.27
```

### Compile with GCC
```sh
./configure --cc=gcc && make
mv tcc libtcc1.a libtcc.a ../gcc-tcc
make clean && make distclean
```

### Compile with Clang
```sh
./configure --cc=clang && make
mv tcc libtcc1.a libtcc.a ../clang-tcc
make clean && make distclean
```

### Try to diff the 1st round
```sh
cd ..
diff clang-tcc gcc-tcc
cd tcc-0.9.27
```

### Compile with GCC-TCC
```sh
./configure --cc=../gcc-tcc/tcc && make
mv tcc libtcc1.a libtcc.a ../gcc-tcc-tcc
make clean && make distclean
```

### Compile with Clang-TCC
```sh
./configure --cc=../clang-tcc/tcc && make
mv tcc libtcc1.a libtcc.a ../clang-tcc-tcc
make clean && make distclean
```

### Try to diff the 2nd round
```sh
cd ..
diff clang-tcc-tcc gcc-tcc-tcc
```

### Generate SHA256 digests
```sh
openssl dgst -sha256 gcc-tcc-tcc/*
openssl dgst -sha256 clang-tcc-tcc/*
```
