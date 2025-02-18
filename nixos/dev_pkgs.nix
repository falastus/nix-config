{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
    # build systems
      autoconf
      autoconf-archive
      automake
      cmake
      gnumake
      meson
      ninja

      # compilers
      # Putting gcc before clang means that `which cc` will be `gcc` instead of
      # `clang`
      gcc
      # gcc-unwrapped with lower priority than gcc so `gcov` is available and
      # `gcc` is still wrapped
      (lib.setPrio (gcc.meta.priority + 1) gcc-unwrapped)

      clang_12
      llvmPackages_12.llvm
      llvmPackages_12.lld

      # testing frameworks
      criterion
      gtest
      gcovr

      # misc
      bintools
      capstone
      check
      checkbashisms
      clang-tools
      ctags
      dash
      doxygen
      fakeroot
      flex
      gdb
      lcov
      ltrace
      pkg-config
      readline
      rr
      shellcheck
      strace
      tk
      valgrind

      # lcov dependencies
      perlPackages.JSON
      perlPackages.PerlIOgzip

      # vcs
      git
      pre-commit
      subversion
      tig

      # sql
      jetbrains.datagrip
      postgresql
      sqlfluff

      # java
      jetbrains.idea-ultimate

      # moi
      glibc
      python3
      python312Packages.pip
      cairo-lang
      cairo

      # net
      gns3-gui
      gns3-server
      inetutils
      pkgsi686Linux.dynamips
      tigervnc
      vpcs
      aria2
      opentracker
      mktorrent
    ];

    virtualisation.virtualbox.host.enable = true;

    security.wrappers.ubridge = {
        source = "${pkgs.ubridge}/bin/ubridge";
        capabilities = "cap_net_admin,cap_net_raw=ep";
        owner = "root";
        group = "root";
        permissions = "u+rx,g+x,o+x";
    };


    environment.variables = {
      ACLOCAL_PATH = "${pkgs.autoconf-archive}/share/aclocal:${pkgs.autoconf}/share/aclocal:${pkgs.automake}/share/aclocal";
    };


    environment.pathsToLink = [
      "/share/postgresql"
    ];
}
