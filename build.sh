#!/bin/bash

# build normal package with GCC

# gcc

# official package

cd edge && makepkg -s && rm -rf pkg/ src/ && cd ..

cd stable && makepkg -s && rm -rf pkg/ src/ && cd ..

cd tt && makepkg -s && rm -rf pkg/ src/ && cd ..

cd lts && makepkg -s && rm -rf pkg/ src/ && cd ..

# non-official package

cd tt-edge && makepkg -s && rm -rf pkg/ src/ && cd ..

cd bore-edge && makepkg -s && rm -rf pkg/ src/ && cd ..

cd bore && makepkg -s && rm -rf pkg/ src/ && cd ..

cd cacule-edge && makepkg -s && rm -rf pkg/ src/ && cd ..

cd cacule-rdb-edge && makepkg -s && rm -rf pkg/ src/ && cd ..

cd cacule && makepkg -s && rm -rf pkg/ src/ && cd ..

cd cacule-rdb && makepkg -s && rm -rf pkg/ src/ && cd ..

# clang

# official package

#cd edge && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd stable && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd tt && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd lts && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

# non-official package

#cd tt-edge && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd bore-edge && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd bore && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd cacule-edge && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd cacule-rdb-edge && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd cacule && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd cacule-rdb && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..
