# linux-xanmod

![image](https://user-images.githubusercontent.com/68618182/124551127-b059b480-ddff-11eb-97af-9664740c4829.png)

XanMod kernel build for Archlinux.

Modified to support (stable only):
- Architecture optimizations (does it matter? not enabled by default)
- Waydroid (PSI enabled by default)
- System76's scheduler (needs debug info to be enabled apparently)
- Other various patches

Run `just --list` for a list of the possibilities

# Version

## Official package

- Edge : 5.18.4-xanmod1

- Stable : 5.18.4-xanmod1

- LTS : 5.15.47-xanmod1

- TT (LTS) : 5.15.47-xanmod1-tt

# Build

    git clone https://github.com/blacksky3/linux-xanmod.git
    cd linux-xanmod/{edge,stable,lts,tt-lts}
    env_compiler=(1 or 2) makepkg -s

# Build variables

### _compiler

- Will set compiler to build the kernel :

        1 : GCC
        2 : CLANG+LLVM

If not set it will build with GCC by default.

# Prebuild package

Prebuild package are available at https://repo.blacksky3.com/x86_64/kernel

You can add this repo to your pacman.conf

    [kernel]
    SigLevel = Optional TrustAll
    Server = https://repo.blacksky3.com/$arch/$repo

# CPU Scheduler

## TT CPU Scheduler

Task Type (TT) is an alternative CPU Scheduler for linux.

The goal of the Task Type (TT) scheduler is to detect tasks types based on their behaviours and control the schedulling based on their types. There are 5 types:

1. REALTIME
2. INTERACTIVE
3. NO_TYPE
4. CPU_BOUND
5. BATCH

Find the descriptions and the detection rules in tasks.ods

The benefit of task types is to allow the scheduler to have more control and choose the best task to run next in the CPU.

TT gives RT tasks a -20 prio in vruntime calculations. This boosts RT tasks over other tasks. The preemption rules are purely HRRN where RT tasks have a priority since their vruntimes are relatively less than other types. The reason of using HRRN instead of hard level picking is to smooth out the preemtions and to prevent any chance of starvation.

# Update GRUB

    sudo grub-mkconfig -o /boot/grub/grub.cfg

# Info

You can refer to this Archlinux page that have lots of useful information to build the kernel and debugging if you have some issues https://wiki.archlinux.org/index.php/Kernel/Traditional_compilation

# Contact info

blacksky3@tuta.io if you have any problems or bugs report.

# Donation

BTC : bc1quz6zcjjy769cn9fd42r89hfh9unr4u2w4sfxer

ETH : 0xF8cBcA16f4eeDfF4a07D173B7fF53906a87b0476

DAI : 0xF8cBcA16f4eeDfF4a07D173B7fF53906a87b0476

LINK : 0xF8cBcA16f4eeDfF4a07D173B7fF53906a87b0476
