#_                   _ _ _  _ _____ _  _
#| | _______   ____ _| | | || |___  | || |
#| |/ / _ \ \ / / _` | | | || |_ / /| || |_
#|   <  __/\ V / (_| | | |__   _/ / |__   _|
#|_|\_\___| \_/ \__,_|_|_|  |_|/_/     |_|

#Maintainer: kevall474 <kevall474@tuta.io> <https://github.com/kevall474>
#Credits: Jan Alexander Steffens (heftig) <heftig@archlinux.org> ---> For the base PKGBUILD
#Credits: Andreas Radke <andyrtr@archlinux.org> ---> For the base PKGBUILD
#Credits: Linus Torvalds ---> For the linux kernel
#Credits: Joan Figueras <ffigue at gmail dot com> ---> For the base PKFBUILD
#Credits: Piotr Gorski <lucjan.lucjanov@gmail.com> <https://github.com/sirlucjan/kernel-patches> ---> For the patches and the base pkgbuild
#Credits: Tk-Glitch <https://github.com/Tk-Glitch> ---> For some patches. base PKGBUILD and prepare script
#Credits: Alexandre Frade <kernel@xanmod.org> <https://github.com/xanmod> <https://xanmod.org/> ---> For the XanMod patched kernel
#Credits: Hamad Al Marri <https://github.com/hamadmarri/cachy-sched> ---> For CacULE CPU Scheduler patch

################# CPU Scheduler #################

#Set CPU Scheduler
#Set '1' for CacULE CPU Scheduler
#Set '2' for CacULE-RDB CPU Scheduler
#Leave empty for no CPU Scheduler
#Default is empty. It will build with no cpu scheduler. To build with cpu shceduler just use : env _cpu_sched=(1 or 2) makepkg -s
if [ -z ${_cpu_sched+x} ]; then
  _cpu_sched=
fi

################################# Arch ################################

ARCH=x86

################################# GCC ################################

# Grap GCC version
# Workarround with GCC 12.0.0. Pluggins don't work, so we have to grap GCC version
# and disable CONFIG_HAVE_GCC_PLUGINS/CONFIG_GCC_PLUGINS

GCC_VERSION=$(gcc -dumpversion)

################################# CC/CXX/HOSTCC/HOSTCXX ################################

#Set compiler to build the kernel
#Set '1' to build with GCC
#Set '2' to build with CLANG and LLVM
#Default is empty. It will build with GCC. To build with different compiler just use : env _compiler=(1 or 2) makepkg -s
if [ -z ${_compiler+x} ]; then
  _compiler=
fi

if [[ "$_compiler" = "1" ]]; then
  _compiler=1
  CC=gcc
  CXX=g++
  HOSTCC=gcc
  HOSTCXX=g++
  buildwith="build with GCC"
elif [[ "$_compiler" = "2" ]]; then
  _compiler=2
  CC=clang
  CXX=clang++
  HOSTCC=clang
  HOSTCXX=clang++
  buildwith="build with CLANG/LLVM"
else
  _compiler=1
  CC=gcc
  CXX=g++
  HOSTCC=gcc
  HOSTCXX=g++
  buildwith="build with GCC"
fi

###################################################################################

# This section set the pkgbase based on the cpu scheduler, so user can build different package based on the cpu scheduler.
if [[ $_cpu_sched = "1" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=xanmod-kernel-cacule-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=xanmod-kernel-cacule-clang
  fi
elif [[ $_cpu_sched = "2" ]]; then
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=xanmod-kernel-cacule-rdb-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=xanmod-kernel-cacule-rdb-clang
  fi
else
  if [[ "$_compiler" = "1" ]]; then
    pkgbase=xanmod-kernel-gcc
  elif [[ "$_compiler" = "2" ]]; then
    pkgbase=xanmod-kernel-clang
  fi
fi
pkgname=("$pkgbase" "$pkgbase-headers")
for _p in "${pkgname[@]}"; do
  eval "package_$_p() {
    $(declare -f "_package${_p#$pkgbase}")
    _package${_p#$pkgbase}
  }"
done
# This section set the version for xanmod version. Sometimes xanmod-cacule is behind the main xanmod patch
if [[ $_cpu_sched = "1" ]] || [[ $_cpu_sched = "2" ]]; then
  pkgver=5.13.7_xanmod1
  versiontag=5.13.7-xanmod1-cacule
else
  pkgver=5.13.7_xanmod1
  versiontag=5.13.7-xanmod1
fi
major=5.13
pkgrel=1
arch=(x86_64)
url="https://xanmod.org/"
license=(GPL-2.0)
makedepends=("bison" "flex" "valgrind" "git" "cmake" "make" "extra-cmake-modules" "libelf" "elfutils"
             "python" "python-appdirs" "python-mako" "python-evdev" "python-sphinx_rtd_theme" "python-graphviz" "python-sphinx"
             "clang" "lib32-clang" "bc" "gcc" "gcc-libs" "lib32-gcc-libs" "glibc" "lib32-glibc" "pahole" "patch" "gtk3" "llvm" "lib32-llvm"
             "llvm-libs" "lib32-llvm-libs" "lld" "kmod" "libmikmod" "lib32-libmikmod" "xmlto" "xmltoman" "graphviz" "imagemagick" "imagemagick-doc"
             "rsync" "cpio" "inetutils" "gzip" "zstd" "xz")
patchsource=https://raw.githubusercontent.com/kevall474/kernel-patches/main/$major
source=("https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-$major.tar.xz")
md5sums=("76c60fb304510a7bbd9c838790bc5fe4")  #linux-5.13.tar.xz

if [[ $_cpu_sched = "1" ]] || [[ $_cpu_sched = "2" ]]; then
  source+=("https://github.com/xanmod/linux/releases/download/$versiontag/patch-$versiontag.xz")
  md5sums+=("SKIP")  #patch-5.13.1-xanmod1-cacule.xz
else
  source+=("https://github.com/xanmod/linux/releases/download/$versiontag/patch-$versiontag.xz")
  md5sums+=("SKIP")  #patch-5.13.1-xanmod1.xz
fi

export KBUILD_BUILD_HOST=archlinux
export KBUILD_BUILD_USER=$pkgbase
export KBUILD_BUILD_TIMESTAMP="$(date -Ru${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH})"

prepare(){

  cd "${srcdir}"/linux-$major

  # hacky work around for xz not getting extracted
  # https://bbs.archlinux.org/viewtopic.php?id=265115
  #if [[ ! -f "$srcdir/patch-$versiontag" ]]; then
  #  unlink "$srcdir/patch-$versiontag.xz"
  #  xz -dc "$startdir/patch-$versiontag.xz" > "$srcdir/patch-$versiontag"
  #fi

  # Apply Xanmod patch
  patch -Np1 -i ../patch-$versiontag

  # Apply any patch
  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    [[ $src = *.patch ]] || continue
    msg2 "Applying patch $src..."
    patch -Np1 < "../$src"
  done

  # Copy the config file first
  # Copy "${srcdir}"/config-$major to linux-${pkgver}/.config
  msg2 "Copy "${srcdir}"/linux-$pkgver/CONFIGS/xanmod to "${srcdir}"/linux-$pkgver/.config"
  if [[ "$_compiler" = "1" ]]; then
    cp CONFIGS/xanmod/gcc/config .config
  elif [[ "$_compiler" = "2" ]]; then
    cp CONFIGS/xanmod/clang/config .config
  fi

  plain ""
  msg2 "Disable LTO"
  scripts/config --disable CONFIG_LTO
  scripts/config --disable CONFIG_LTO_CLANG
  scripts/config --disable CONFIG_ARCH_SUPPORTS_LTO_CLANG
  scripts/config --disable CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN
  scripts/config --disable CONFIG_HAS_LTO_CLANG
  scripts/config --disable CONFIG_LTO_NONE
  scripts/config --disable CONFIG_LTO_CLANG_FULL
  scripts/config --disable CONFIG_LTO_CLANG_THIN

  sleep 2s

  # fix for GCC 12.0.0 (git version)
  # plugins don't work
  # disable plugins
  #if [[ "$GCC_VERSION" = "12.0.0" ]] && [[ "$_compiler" = "1" ]]; then
  #  plain ""
  #  msg2 "Disable CONFIG_HAVE_GCC_PLUGINS/CONFIG_GCC_PLUGINS (Quick fix for gcc 12.0.0 git version)"
  #  scripts/config --disable CONFIG_HAVE_GCC_PLUGINS
  #  scripts/config --disable CONFIG_GCC_PLUGINS
  #  plain ""
  #  sleep 2s
  #fi

  plain ""

  msg2 "Set SIG level to SHA512"
  scripts/config --undefine MODULE_SIG_FORCE
  scripts/config --disable MODULE_SIG_FORCE
  scripts/config --enable CONFIG_MODULE_SIG
  scripts/config --enable CONFIG_MODULE_SIG_ALL
  scripts/config --disable CONFIG_MODULE_SIG_SHA1
  scripts/config --disable CONFIG_MODULE_SIG_SHA224
  scripts/config --disable CONFIG_MODULE_SIG_SHA256
  scripts/config --disable CONFIG_MODULE_SIG_SHA384
  scripts/config --enable CONFIG_MODULE_SIG_SHA512
  scripts/config  --set-val CONFIG_MODULE_SIG_HASH "sha512"

  sleep 2s

  msg2 "Set module compression to ZSTD"
  scripts/config --disable CONFIG_MODULE_COMPRESS_NONE
  scripts/config --disable CONFIG_MODULE_COMPRESS_GZIP
  scripts/config --disable CONFIG_MODULE_COMPRESS_XZ
  scripts/config --enable CONFIG_MODULE_COMPRESS_ZSTD

  sleep 2s

  msg2 "Enable CONFIG_STACK_VALIDATION"
  scripts/config --enable CONFIG_STACK_VALIDATION

  sleep 2s

  msg2 "Enable IKCONFIG"
  scripts/config --enable CONFIG_IKCONFIG
  scripts/config --enable CONFIG_IKCONFIG_PROC

  sleep 2s

  msg2 "Disable NUMA"
  scripts/config --disable CONFIG_NUMA
  scripts/config --disable CONFIG_AMD_NUMA
  scripts/config --disable CONFIG_X86_64_ACPI_NUMA
  scripts/config --disable CONFIG_NODES_SPAN_OTHER_NODES
  scripts/config --disable CONFIG_NUMA_EMU
  scripts/config --disable CONFIG_NEED_MULTIPLE_NODES
  scripts/config --disable CONFIG_USE_PERCPU_NUMA_NODE_ID
  scripts/config --disable CONFIG_ACPI_NUMA
  scripts/config --disable CONFIG_ARCH_SUPPORTS_NUMA_BALANCING
  scripts/config --disable CONFIG_NODES_SHIFT
  scripts/config --undefine CONFIG_NODES_SHIFT
  scripts/config --disable CONFIG_NEED_MULTIPLE_NODES

  sleep 2s

  msg2 "Disable FUNCTION_TRACER/GRAPH_TRACER"
  scripts/config --disable CONFIG_FUNCTION_TRACER
  scripts/config --disable CONFIG_STACK_TRACER

  sleep 2s

  msg2 "Disable CONFIG_USER_NS_UNPRIVILEGED"
  scripts/config --enable CONFIG_USER_NS_UNPRIVILEGED

  sleep 2s

  msg2 "Set CPU Frequency scaling CONFIG_CPU_FREQ_DEFAULT_GOV/CONFIG_CPU_FREQ_GOV for performance"
  scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE
  scripts/config --disable CONFIG_CPU_FREQ_GOV_POWERSAVE
  scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE
  scripts/config --disable CONFIG_CPU_FREQ_GOV_USERSPACE
  scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
  scripts/config --disable CONFIG_CPU_FREQ_GOV_ONDEMAND
  scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
  scripts/config --disable CONFIG_CPU_FREQ_GOV_CONSERVATIVE
  scripts/config --disable CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
  scripts/config --disable CONFIG_CPU_FREQ_GOV_SCHEDUTIL
  scripts/config --enable CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
  scripts/config --enable CONFIG_CPU_FREQ_GOV_PERFORMANCE

  sleep 2s

  msg2 "Set CPU DEVFREQ GOV CONFIG_DEVFREQ_GOV for performance"
  scripts/config --disable CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND
  scripts/config --undefine CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND
  scripts/config --disable CONFIG_DEVFREQ_GOV_POWERSAVE
  scripts/config --disable CONFIG_DEVFREQ_GOV_USERSPACE
  scripts/config --disable CONFIG_DEVFREQ_GOV_PASSIVE
  scripts/config --enable CONFIG_DEVFREQ_GOV_PERFORMANCE

  sleep 2s

  msg2 "Set PCIEASPM DRIVER to performance"
  scripts/config --enable CONFIG_PCIEASPM
  scripts/config --enable CONFIG_PCIEASPM_PERFORMANCE

  sleep 2s

  msg2 "Set CONFIG_PCIE_BUS for performance"
  scripts/config --enable CONFIG_PCIE_BUS_PERFORMANCE

  sleep 2s

  msg2 "Enable CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3"
  scripts/config --disable CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
  scripts/config --disable CONFIG_CC_OPTIMIZE_FOR_SIZE
  scripts/config --enable CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3

  sleep 2s

  if [[ $_cpu_sched = "1" ]] || [[ $_cpu_sched = "2" ]]; then
    msg2 "Set timer frequency to 2000HZ"
    scripts/config --enable CONFIG_HZ_2000
    scripts/config --set-val CONFIG_HZ 2000
  else
    msg2 "Set timer frequency to 1000HZ"
    scripts/config --enable CONFIG_HZ_1000
    scripts/config --set-val CONFIG_HZ 1000
  fi

  sleep 2s

  msg2 "Enable PREEMPT"
  scripts/config --disable CONFIG_PREEMPT_NONE
  scripts/config --disable CONFIG_PREEMPT_VOLUNTARY
  scripts/config --enable CONFIG_PREEMPT
  scripts/config --enable CONFIG_PREEMPT_COUNT
  scripts/config --enable CONFIG_PREEMPTION

  sleep 2s

  msg2 "Set to full tickless"
  scripts/config --disable CONFIG_HZ_PERIODIC
  scripts/config --disable CONFIG_NO_HZ_IDLE
  scripts/config --enable CONFIG_NO_HZ_FULL
  scripts/config --enable CONFIG_NO_HZ
  scripts/config --enable CONFIG_NO_HZ_COMMON
  #scripts/config --enable CONFIG_CONTEXT_TRACKING
  #scripts/config --disable CONFIG_CONTEXT_TRACKING_FORCE

  sleep 2s

  msg2 "Enable ntfs"
  scripts/config --module CONFIG_NTFS_FS
  scripts/config --enable CONFIG_NTFS_RW
  msg2 "Enable ntfs3"
  scripts/config --module CONFIG_NTFS3_FS
  scripts/config --enable CONFIG_NTFS3_64BIT_CLUSTER
  scripts/config --enable CONFIG_NTFS3_LZX_XPRESS
  scripts/config --enable CONFIG_NTFS3_FS_POSIX_ACL

  sleep 2s

  msg2 "Enable BBR/BBR2 TCP"
  scripts/config --module CONFIG_TCP_CONG_BBR
  scripts/config --module CONFIG_TCP_CONG_BBR2

  sleep 2s

  msg2 "Disabling Kyber I/O scheduler"
  scripts/config --disable CONFIG_MQ_IOSCHED_KYBER

  sleep 2s

  msg2 "Enable Deadline I/O scheduler"
  scripts/config --enable CONFIG_MQ_IOSCHED_DEADLINE

  sleep 2s

  msg2 "Enable CONFIG_BFQ_CGROUP_DEBUG"
  scripts/config --enable CONFIG_BFQ_CGROUP_DEBUG

  sleep 2s

  msg2 "Enable CONFIG_SCHED_AUTOGROUP_DEFAULT_ENABLED"
  scripts/config --enable CONFIG_SCHED_AUTOGROUP_DEFAULT_ENABLED

  sleep 2s

  msg2 "Enable Fsync support"
  scripts/config --enable CONFIG_FUTEX
  scripts/config --enable CONFIG_FUTEX_PI

  sleep 2s

  msg2 "Enable Futex2 support"
  scripts/config --enable CONFIG_FUTEX2

  sleep 2s

  msg2 "Enable SECURITY_FORK_BRUT"
  scripts/config --enable CONFIG_SECURITY_FORK_BRUT

  sleep 2s

  msg2 "Enable LRNG"
  scripts/config --enable CONFIG_LRNG
  scripts/config --enable CONFIG_LRNG_OVERSAMPLE_ENTROPY_SOURCES
  scripts/config --enable CONFIG_LRNG_CONTINUOUS_COMPRESSION_ENABLED
  scripts/config --enable CONFIG_LRNG_ENABLE_CONTINUOUS_COMPRESSION
  scripts/config --enable CONFIG_LRNG_SWITCHABLE_CONTINUOUS_COMPRESSION
  scripts/config --enable CONFIG_LRNG_COLLECTION_SIZE_1024

  sleep 2s

  msg2 "Enable LRU"
  scripts/config --enable CONFIG_LRU_GEN
  scripts/config --enable CONFIG_LRU_GEN_ENABLED
  scripts/config --enable CONFIG_LRU_GEN_STATS

  sleep 2s

  if [[ $_cpu_sched = "1" ]]; then
    msg2 "Enable CacULE CPU scheduler"
    scripts/config --enable CONFIG_CACULE_SCHED
    msg2 "Disable CacULE-RDB CPU scheduler"
    scripts/config --disable CONFIG_CACULE_RDB
  elif [[ $_cpu_sched = "2" ]]; then
    msg2 "Enable CacULE CPU scheduler"
    scripts/config --enable CONFIG_CACULE_SCHED
    msg2 "Enable CacULE-RDB CPU scheduler"
    scripts/config --enable CONFIG_CACULE_RDB
  else
    msg2 "Enable CFS"
    scripts/config --enable SCHED_NORMAL
    scripts/config --enable SCHED_BATCH
    scripts/config --enable SCHED_IDLE
    scripts/config --enable CONFIG_CGROUP_SCHED
    scripts/config --enable CONFIG_FAIR_GROUP_SCHED
    scripts/config --enable CONFIG_CFS_BANDWIDTH
    scripts/config --enable CONFIG_SCHED_DEBUG
  fi

  sleep 2s

  if [[ $_cpu_sched = "1" ]] || [[ $_cpu_sched = "2" ]]; then
    msg2 "Apply suggested config by Hamad Al Marri for CacULE"
    # General Setup
    echo "General Setup"
    sleep 1s
    scripts/config --disable CONFIG_EXPERT
    # Note:
    # CONFIG_NO_HZ_FULL requires you to add
    # the boot parameter "nohz_full=" in your
    # grup. For example, in case your machine
    # has 8 CPUS, "nohz_full=1-7" makes
    # all CPUs (except CPU0) adaptive ticks.
    # Without "nohz_full=1-7", no benfit of
    # selecting CONFIG_NO_HZ_FULL
    #
    # Please see the discussion here:
    # https://github.com/hamadmarri/cacule-cpu-scheduler/discussions/23#discussioncomment-711456
    #scripts/config --enable CONFIG_NO_HZ_FULL

    scripts/config --enable CONFIG_PREEMPT
    scripts/config --enable CONFIG_SCHED_AUTOGROUP
    scripts/config --disable CONFIG_BSD_PROCESS_ACCT
    scripts/config --disable CONFIG_TASK_XACCT
    scripts/config --disable CONFIG_PSI
    scripts/config --disable CONFIG_MEMCG
    scripts/config --disable CONFIG_CGROUP_CPUACCT
    scripts/config --disable CONFIG_CGROUP_DEBUG
    scripts/config --disable CONFIG_CHECKPOINT_RESTORE
    scripts/config --disable CONFIG_SLAB_MERGE_DEFAULT
    scripts/config --disable CONFIG_SLAB_FREELIST_HARDENED
    scripts/config --disable CONFIG_SLUB_CPU_PARTIAL
    scripts/config --disable CONFIG_PROFILING
    # Processor type and features
    echo "Processor type and features"
    sleep 1s
    scripts/config --disable CONFIG_RETPOLINE
    scripts/config --disable CONFIG_X86_5LEVEL
    scripts/config --disable CONFIG_KEXEC
    scripts/config --disable CONFIG_KEXEC_FILE
    scripts/config --disable CONFIG_CRASH_DUMP
    #scripts/config --set-val CONFIG_NR_CPUS $(nproc)
    # if you are not using this kernel as guest in a virtual machine,
    # then disable CONFIG_HYPERVISOR_GUEST
    #./scripts/config --disable CONFIG_HYPERVISOR_GUEST
    # General architecture-dependent options
    echo "General architecture-dependent options"
    sleep 1s
    scripts/config --disable CONFIG_KPROBES
    # Kernel hacking
    echo "Kernel hacking"
    sleep 1s
    scripts/config --disable CONFIG_FTRACE
    scripts/config --disable CONFIG_DEBUG_KERNEL
    scripts/config --disable CONFIG_PAGE_EXTENSION
    scripts/config --set-val CONFIG_RCU_CPU_STALL_TIMEOUT 4
    scripts/config --disable CONFIG_PRINTK_TIME
    scripts/config --disable CONFIG_DEBUG_INFO
    scripts/config --disable CONFIG_ENABLE_MUST_CHECK
    scripts/config --disable CONFIG_STRIP_ASM_SYMS
    scripts/config --disable CONFIG_UNUSED_SYMBOLS
    scripts/config --disable CONFIG_DEBUG_FS
    scripts/config --disable CONFIG_OPTIMIZE_INLINING
    scripts/config --disable CONFIG_DEBUG_SECTION_MISMATCH
    scripts/config --disable CONFIG_SECTION_MISMATCH_WARN_ONLY
    scripts/config --disable CONFIG_STACK_VALIDATION
    scripts/config --disable CONFIG_DEBUG_FORCE_WEAK_PER_CPU
    scripts/config --disable CONFIG_MAGIC_SYSRQ
    scripts/config --disable CONFIG_MAGIC_SYSRQ_SERIAL
    scripts/config --disable CONFIG_PAGE_EXTENSION
    scripts/config --disable CONFIG_DEBUG_PAGEALLOC
    scripts/config --disable CONFIG_PAGE_OWNER
    scripts/config --disable CONFIG_DEBUG_MEMORY_INIT
    scripts/config --disable CONFIG_HARDLOCKUP_DETECTOR
    scripts/config --disable CONFIG_SOFTLOCKUP_DETECTOR
    scripts/config --disable CONFIG_DETECT_HUNG_TASK
    scripts/config --disable CONFIG_WQ_WATCHDOG
    scripts/config --set-val CONFIG_PANIC_TIMEOUT 10
    scripts/config --disable CONFIG_SCHED_DEBUG
    scripts/config --disable CONFIG_SCHEDSTATS
    scripts/config --disable CONFIG_SCHED_STACK_END_CHECK
    scripts/config --disable CONFIG_STACKTRACE
    scripts/config --disable CONFIG_DEBUG_BUGVERBOSE
    scripts/config --set-val CONFIG_RCU_CPU_STALL_TIMEOUT 4
    scripts/config --disable CONFIG_RCU_TRACE
    scripts/config --disable CONFIG_FAULT_INJECTION
    scripts/config --disable CONFIG_LATENCYTOP
    scripts/config --disable CONFIG_PROVIDE_OHCI1394_DMA_INIT
    scripts/config --disable RUNTIME_TESTING_MENU
    scripts/config --disable CONFIG_MEMTEST
    scripts/config --disable CONFIG_KGDB
    scripts/config --disable CONFIG_EARLY_PRINTK
    scripts/config --disable CONFIG_DOUBLEFAULT

    sleep 2s
  fi

  msg2 "Set CONFIG_GENERIC_CPU"
  scripts/config --enable CONFIG_GENERIC_CPU

  sleep 2s

  # Setting localversion
  msg2 "Setting localversion..."
  scripts/setlocalversion --save-scmversion
  echo "-${pkgbase}" > localversion-pkgbuild

  # Config
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} olddefconfig
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} olddefconfig
  fi

  make -s kernelrelease > version
  msg2 "Prepared $pkgbase version $(<version)"
}

build(){

  cd "${srcdir}"/linux-$major

  # make -j$(nproc) all
  msg2 "make -j$(nproc) all..."
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} -j$(nproc) all
  fi
}

_package(){
  pkgdesc="XanMod kernel and modules with a set of patches by TK-Glitch and Piotr Górski"
  depends=("coreutils" "kmod" "initramfs" "mkinitcpio")
  optdepends=("linux-firmware: firmware images needed for some devices"
              "crda: to set the correct wireless channels of your country"
              "winesync-headers: headers file for winesync module")
  provides=("VIRTUALBOX-GUEST-MODULES" "WIREGUARD-MODULE")

  cd "${srcdir}"/linux-$major

  local kernver="$(<version)"
  local modulesdir="${pkgdir}"/usr/lib/modules/${kernver}

  msg2 "Installing boot image..."
  # systemd expects to find the kernel here to allow hibernation
  # https://github.com/systemd/systemd/commit/edda44605f06a41fb86b7ab8128dcf99161d2344
  #install -Dm644 arch/${ARCH}/boot/bzImage "$modulesdir/vmlinuz"
  install -Dm644 "$(make -s image_name)" "$modulesdir/vmlinuz"

  # Used by mkinitcpio to name the kernel
  echo "$pkgbase" | install -Dm644 /dev/stdin "$modulesdir/pkgbase"

  msg2 "Installing modules..."
  if [[ "$_compiler" = "1" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} INSTALL_MOD_PATH="${pkgdir}"/usr INSTALL_MOD_STRIP=1 -j$(nproc) modules_install
  elif [[ "$_compiler" = "2" ]]; then
    make ARCH=${ARCH} CC=${CC} CXX=${CXX} LLVM=1 LLVM_IAS=1 HOSTCC=${HOSTCC} HOSTCXX=${HOSTCXX} INSTALL_MOD_PATH="${pkgdir}"/usr INSTALL_MOD_STRIP=1 -j$(nproc) modules_install
  fi

  # remove build and source links
  msg2 "Remove build dir and source dir..."
  rm -rf "$modulesdir"/{source,build}
}

_package-headers(){
  pkgdesc="Headers and scripts for building modules for the $pkgbase package"
  depends=("${pkgbase}" "pahole")

  cd "${srcdir}"/linux-$major

  local builddir="$pkgdir"/usr/lib/modules/"$(<version)"/build

  msg2 "Installing build files..."
  install -Dt "$builddir" -m644 .config Makefile Module.symvers System.map localversion version vmlinux
  install -Dt "$builddir/kernel" -m644 kernel/Makefile
  install -Dt "$builddir/arch/x86" -m644 arch/x86/Makefile
  cp -t "$builddir" -a scripts

  # add objtool for external module building and enabled VALIDATION_STACK option
  install -Dt "$builddir/tools/objtool" tools/objtool/objtool

  # add xfs and shmem for aufs building
  mkdir -p "$builddir"/{fs/xfs,mm}

  msg2 "Installing headers..."
  cp -t "$builddir" -a include
  cp -t "$builddir/arch/x86" -a arch/x86/include
  install -Dt "$builddir/arch/x86/kernel" -m644 arch/x86/kernel/asm-offsets.s

  install -Dt "$builddir/drivers/md" -m644 drivers/md/*.h
  install -Dt "$builddir/net/mac80211" -m644 net/mac80211/*.h

  # https://bugs.archlinux.org/task/13146
  install -Dt "$builddir/drivers/media/i2c" -m644 drivers/media/i2c/msp3400-driver.h

  # https://bugs.archlinux.org/task/20402
  install -Dt "$builddir/drivers/media/usb/dvb-usb" -m644 drivers/media/usb/dvb-usb/*.h
  install -Dt "$builddir/drivers/media/dvb-frontends" -m644 drivers/media/dvb-frontends/*.h
  install -Dt "$builddir/drivers/media/tuners" -m644 drivers/media/tuners/*.h

  # https://bugs.archlinux.org/task/71392
  install -Dt "$builddir/drivers/iio/common/hid-sensors" -m644 drivers/iio/common/hid-sensors/*.h

  msg2 "Installing KConfig files..."
  find . -name 'Kconfig*' -exec install -Dm644 {} "$builddir/{}" \;

  msg2 "Removing unneeded architectures..."
  local arch
  for arch in "$builddir"/arch/*/; do
    [[ $arch = */x86/ ]] && continue
    msg2 "Removing $(basename "$arch")"
    rm -r "$arch"
  done

  msg2 "Removing documentation..."
  rm -r "$builddir/Documentation"

  msg2 "Removing broken symlinks..."
  find -L "$builddir" -type l -printf 'Removing %P\n' -delete

  msg2 "Removing loose objects..."
  find "$builddir" -type f -name '*.o' -printf 'Removing %P\n' -delete

  msg2 "Stripping build tools..."
  local file
  while read -rd '' file; do
    case "$(file -bi "$file")" in
      application/x-sharedlib\;*)      # Libraries (.so)
        strip -v $STRIP_SHARED "$file" ;;
      application/x-archive\;*)        # Libraries (.a)
        strip -v $STRIP_STATIC "$file" ;;
      application/x-executable\;*)     # Binaries
        strip -v $STRIP_BINARIES "$file" ;;
      application/x-pie-executable\;*) # Relocatable binaries
        strip -v $STRIP_SHARED "$file" ;;
    esac
  done < <(find "$builddir" -type f -perm -u+x ! -name vmlinux -print0)

  msg2 "Stripping vmlinux..."
  strip -v $STRIP_STATIC "$builddir/vmlinux"

  msg2 "Adding symlink..."
  mkdir -p "$pkgdir/usr/src"
  ln -sr "$builddir" "$pkgdir/usr/src/$pkgbase"
}
