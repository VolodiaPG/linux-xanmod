# XanMod

![image](https://user-images.githubusercontent.com/68618182/124551127-b059b480-ddff-11eb-97af-9664740c4829.png)

XanMod kernel build for Archlinux.

# Version


- 5.15.10-xanmod1

- 5.15.10-xanmod1-tt

- 5.10.87-xanmod1

- 5.15.10-xanmod1-bore-baby ( unofficial package created by me :P )

- 5.15.10-xanmod1-bore-cacule ( unofficial package created by me :P )

- 5.15.10-xanmod1-pds ( unofficial package created by me :P )

- 5.15.10-xanmod1-bmq ( unofficial package created by me :P )



# Build

    git clone https://github.com/kevall474/XanMod.git
    cd XanMod 
    cd stable && env _cpu_sched=(1,2,3,4 or 5) _compiler=(1 or 2) makepkg -s
    or
    cd lts && env _compiler=(1 or 2) makepkg -s

# Build variables

### _cpu_sched

- Will add a CPU Scheduler :

        1 : TT CPU Scheduler by Hamad Al Marri
        2 : BORE (Burst-Oriented Response Enhancer) CPU Scheduler by Masahito Suzuki based on Baby CPU Scheduler by Hamad Al Marri
        3 : BORE (Burst-Oriented Response Enhancer) CPU Scheduler by Masahito Suzuki based on CacULE and Baby CPU Scheduler by Hamad Al Marri
        4 : PDS by Alfred Chen
        5 : BMQ by Alfred Chen

Leave this variable empty if you don't want to add a CPU Scheduler.

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
