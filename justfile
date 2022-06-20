# Env variables
# Number of cpus to be involed in the build, automatically retrieved
export MAKEFLAGS := "-j $(grep -c ^processor /proc/cpuinfo)"

# Build the kernel. Defaults to "CONFIG_GENERIC_CPU"
build $_arch_opti="CONFIG_GENERIC_CPU":
  # _arch_opti is also exported as env variable
  @echo "Making {{_arch_opti}} optimized build. Your detected architecture was $(gcc -c -Q -march=native --help=target | grep march | awk '{print $2}' | head -1)"
  cp -r stable {{_arch_opti}} && cd {{_arch_opti}} && makepkg -s

# makepkg for intel arch for haswell and newer
intel: (build "CONFIG_GENERIC_CPU3")

# makepkg -s for Skylake arch
skylake: (build "CONFIG_MSKYLAKE")

# makepkg -s for Haswell arch
haswell: (build "CONFIG_MHASWELL")

# Install and update grub. Must be invoked from the directory where the package to be installed is at
install:
  @echo "Installing kernel located at {{invocation_directory()}}"
  cd {{invocation_directory()}} && makepkg -i
  sudo grub-mkconfig -o /boot/grub/grub.cfg 

# Clean
clean:
  rm -rf CONFIG*
