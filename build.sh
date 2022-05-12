#!/bin/bash

# build normal package with GCC

# gcc

# official package

cd edge && makepkg -s && rm -rf pkg/ src/ && cd ..

cd stable && makepkg -s && rm -rf pkg/ src/ && cd ..

cd lts && makepkg -s && rm -rf pkg/ src/ && cd ..

cd tt-lts && makepkg -s && rm -rf pkg/ src/ && cd ..

# clang

# official package

#cd edge && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd stable && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd lts && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd tt-lts && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..
