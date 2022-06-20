# Env variables
# Number of cpus to be involed in the build, automatically retrieved
export MAKEFLAGS := "-j $(grep -c ^processor /proc/cpuinfo)"

# Build the kernel. Defaults to "CONFIG_GENERIC_CPU"
build $_archi_opti="CONFIG_GENERIC_CPU":
  # _archi_opti is also exported as env variable
  @echo "Making {{_archi_opti}} optimized build"
  cp -r stable {{_archi_opti}} && cd {{_archi_opti}} && makepkg -s

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