#!/bin/bash

# build normal package with GCC

# gcc

cd edge && makepkg -s && rm -rf pkg/ src/ && cd ..

cd stable && makepkg -s && rm -rf pkg/ src/ && cd ..

cd tt && makepkg -s && rm -rf pkg/ src/ && cd ..

cd lts && makepkg -s && rm -rf pkg/ src/ && cd ..

cd bore && makepkg -s && rm -rf pkg/ src/ && cd ..

# clang

#cd edge && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd stable && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd tt && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd lts && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..

#cd bore && env _compiler=2 makepkg -s && rm -rf pkg/ src/ && cd ..
