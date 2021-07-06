# XanMod

XanMod kernel build for Archlinux with a patch set by TK-Glitch, Piotr Górski and Hamad Al Marri.

# Version

- 5.13

# Build

    git clone https://github.com/kevall474/Linux.git
    cd Linux
    env _cpu_sched=(1,2,3 or 4) _compiler=(1 or 2) makepkg -s

# Build variables

### _cpu_sched

- Will add a CPU Scheduler :

        1 : CacULE by Hamad Al Marri
        2 : CacULE-RDB by Hamad Al Marri
        3 : BMQ by Alfred Chen
        4 : PDS by Alfred Chen

Leave this variable empty if you don't want to add a CPU Scheduler.

### _compiler

- Will set compiler to build the kernel :

        1 : GCC
        2 : CLANG+LLVM

If not set it will build with GCC by default.

# CPU Scheduler

## CacULE CPU Scheduler

![cacule_sched](https://user-images.githubusercontent.com/68618182/103179297-92ac0100-4858-11eb-83aa-8992f33d67f8.png)

CacULE is a newer version of Cachy. The CacULE CPU scheduler is based on interactivity score mechanism.
The interactivity score is inspired by the ULE scheduler (FreeBSD scheduler).

About CacULE Scheduler

- Each CPU has its own runqueue.
- NORMAL runqueue is a linked list of sched_entities (instead of RB-Tree).
- RT and other runqueues are just the same as the CFS's.
- Wake up tasks preempt currently running tasks if its interactivity score value is higher.

### RDB load balancer

An experimental load balancer for CacULE. It is a lightweight load balancer which is a replacement of CFS load balancer.
It migrates tasks based on their interactivity scores.


# Update GRUB

    sudo grub-mkconfig -o /boot/grub/grub.cfg

# Contact info

kevall474@tuta.io if you have any problems or bugs report.

# Info

You can refer to this Archlinux page that have lots of useful information to build the kernel and debugging if you have some issues https://wiki.archlinux.org/index.php/Kernel/Traditional_compilation
