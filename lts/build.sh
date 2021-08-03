#!/usr/bin/bash

# gcc

makepkg -s

rm -rf pkg src

# clang

env _compiler=2 makepkg -s

rm -rf pkg src
