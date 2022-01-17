# XanMod

![image](https://user-images.githubusercontent.com/68618182/124551127-b059b480-ddff-11eb-97af-9664740c4829.png)

XanMod kernel build for Archlinux.

# Version

- Edge : 5.16.1-xanmod1

- Stable : 5.15.15-xanmod1

- TT : 5.15.15-xanmod1-tt

- LTS : 5.10.92-xanmod1

- BORE : 5.15.15-xanmod1-bore ( unofficial package created by me )

# Build

    git clone https://github.com/kevall474/XanMod.git
    cd XanMod/{edge,stable,tt,lts.bore}
    env_compiler=(1 or 2) makepkg -s

# Build variables

### _compiler

- Will set compiler to build the kernel :

        1 : GCC
        2 : CLANG+LLVM

If not set it will build with GCC by default.

# CPU Scheduler

To come ...

# Update GRUB

    sudo grub-mkconfig -o /boot/grub/grub.cfg

# Contact info

kevall474@tuta.io if you have any problems or bugs report.

# Info

You can refer to this Archlinux page that have lots of useful information to build the kernel and debugging if you have some issues https://wiki.archlinux.org/index.php/Kernel/Traditional_compilation
