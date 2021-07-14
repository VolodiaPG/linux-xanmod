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
  pkgver=5.13.1_xanmod1
  versiontag=5.13.1-xanmod1-cacule
else
  pkgver=5.13.1_xanmod1
  versiontag=5.13.1-xanmod1
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
source=("https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-$major.tar.xz"
        "$patchsource/bcachefs-patches/0001-bcachefs-5.13-introduce-bcachefs-patchset.patch"
        "$patchsource/bfq-patches/0001-bfq-patches.patch"
        "$patchsource/btrfs-patches/0001-btrfs-patches.patch"
        "$patchsource/cpu-patches/0003-init-Kconfig-add-O1-flag.patch"
        "https://raw.githubusercontent.com/kevall474/kernel-patches/main/5.12/compaction-patches/0001-compaction-patches.patch"
        "$patchsource/futex-patches/0001-futex-resync-from-gitlab.collabora.com.patch"
        "$patchsource/ksm-patches/0001-ksm-patches.patch"
        "$patchsource/loopback-patches/0001-v4l2loopback-patches.patch"
        "$patchsource/lqx-patches/0001-zen-Allow-MSR-writes-by-default.patch"
        "$patchsource/pf-patches/0001-pf-patches.patch"
        "$patchsource/wine-patches/0007-v5.13-winesync.patch"
        "$patchsource/zen-patches/0001-ZEN-Add-VHBA-driver.patch"
        "$patchsource/zen-patches/0003-ZEN-vhba-Update-to-20210418.patch"
        "$patchsource/zen-patches/0002-ZEN-intel-pstate-Implement-enable-parameter.patch"
        "$patchsource/zstd-patches/0001-zstd-patches.patch"
        "$patchsource/zstd-dev-patches/0001-zstd-dev-patches.patch"
        "$patchsource/misc-patches/0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch"
        "$patchsource/misc-patches/0002-mm-Support-soft-dirty-flag-read-with-reset.patch"
        "$patchsource/misc-patches/0003-sched-core-nr_migrate-256-increases-number-of-tasks-.patch"
        "$patchsource/misc-patches/0004-mm-set-8-megabytes-for-address_space-level-file-read.patch"
        "$patchsource/misc-patches/0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch"
        "$patchsource/misc-patches/vm.max_map_count.patch")
md5sums=("76c60fb304510a7bbd9c838790bc5fe4"  #linux-5.13.tar.xz
         "f9dd96a59d6a84e451736e697a897227"  #0001-bcachefs-5.13-introduce-bcachefs-patchset.patch
         "e16eb528e701193bc8cb1facc6b27231"  #0001-bfq-patches.patch
         "63078800040b2a9a9f19c59c4ebf5b23"  #0001-btrfs-patches.patch
         "9ed92b6421a4829c3be67af8e4b65a04"  #0003-init-Kconfig-add-O1-flag.patch
         "98564f54c3f9a6da56c6156d26b3ea39"  #0001-compaction-patches.patch
         "85f4be6562ee033b83814353a12b61bd"  #0001-futex-resync-from-gitlab.collabora.com.patch
         "ce9beff503ee9e6ce6fd983c1bbbdd9e"  #0001-ksm-patches.patch
         "ef7748efcae55f7db8961227cbae3677"  #0001-v4l2loopback-patches.patch
         "09a9e83b7b828fae46fd1a4f4cc23c28"  #0001-zen-Allow-MSR-writes-by-default.patch
         "ed46a39e062f07693f52981fbd7350b7"  #0001-pf-patches.patch
         "9573b92353399343db8a691c9b208300"  #0007-v5.13-winesync.patch
         "6130dd0033e44e9ee3cacbbfe578ff06"  #0001-ZEN-Add-VHBA-driver.patch
         "8a9f82e7cbac3eb60ff23ab7221625ad"  #0003-ZEN-vhba-Update-to-20210418.patch
         "55ae1e0dd0d7024a3e825a4468d87e50"  #0002-ZEN-intel-pstate-Implement-enable-parameter.patch
         "b79559e409253824cf6c569dfe9a7d7f"  #0001-zstd-patches.patch
         "24e975eef21cfdabfab86d80d19a1f83"  #0001-zstd-dev-patches.patch
         "d6b3bcd857e74530a9d0347c6dc05c13"  #0001-mm-Support-soft-dirty-flag-reset-for-VA-range.patch
         "1e7a53eae980951494ee630853d39d98"  #0002-mm-Support-soft-dirty-flag-read-with-reset.patch
         "b3388af517abd48879b7890dae935286"  #0003-sched-core-nr_migrate-256-increases-number-of-tasks-.patch
         "26be410fdc6d7c4f4e122a74fda6f96b"  #0004-mm-set-8-megabytes-for-address_space-level-file-read.patch
         "8d51ee9dd00a1b0c75dc076b4710d5ca"  #0005-Disable-CPU_FREQ_GOV_SCHEDUTIL.patch
         "27e6001bacfcfca1c161bf6ef946a79b") #vm.max_map_count.patch
#zenify workarround with CacULE
if [[ $_cpu_sched != "1" ]] && [[ $_cpu_sched != "2" ]]; then
  source+=("$patchsource/misc-patches/zenify.patch")
  md5sums+=("dbeccd72f6b3d8245a216b572780e170")  #zenify.patch
fi
if [[ $_cpu_sched = "1" ]] || [[ $_cpu_sched = "2" ]]; then
  source+=("https://github.com/xanmod/linux/releases/download/$versiontag/patch-$versiontag.xz")
  md5sums+=("49af7b7197c5c80862357da3e492b054")  #patch-5.13.1-xanmod1-cacule.xz
else
  source+=("https://github.com/xanmod/linux/releases/download/$versiontag/patch-$versiontag.xz")
  md5sums+=("fcbee49f0a6e3b344eb34d0be16b7ea7")  #patch-5.13.1-xanmod1.xz
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
    cp CONFIGS/xanmod/gcc/config .config
  fi
  
  # Disable LTO
  if [[ "$_compiler" = "1" ]] || [[ "$_compiler" = "2" ]]; then
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
  fi
  
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

  # Customize the kernel
  source "${startdir}"/prepare

  configure

  cpu_arch

  # Automation building with rapid_config
  # Uncomment rapid_config and comment out configure and cpu_arch
  # rapid_config is meant to work with build.sh for automation building
  #rapid_config

  # Setting localversion
  msg2 "Setting localversion..."
  scripts/setlocalversion --save-scmversion
  echo "-${pkgbase}" > localversion

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
