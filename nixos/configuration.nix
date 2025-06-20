# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
            ./dev_pkgs.nix
        ];

# Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    hardware = {
        opengl.enable = true;
    };

    networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
        networking.networkmanager.enable = true;

    hardware.bluetooth.enable = true; # enables support for Bluetooth
        hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = false;

    users.groups.ubridge = {};

# Set your time zone.
    time.timeZone = "Europe/Paris";

# Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
    };

    security.rtkit.enable = true;

    programs.hyprland = {
# Install the packages from nixpkgs
        enable = true;
# Whether to enable XWayland
        xwayland.enable = true;
    };

    services = {
        xserver = {
            enable = true;
            desktopManager = {
                xterm.enable = false;
                xfce = {
                    enable = true;
                    noDesktop = true;
                    enableXfwm = false;
                };
            };
        };
        displayManager = {
            sddm.enable = true;
            defaultSession = "hyprland";
        };
        gvfs.enable = true;
        gnome.gnome-keyring.enable = true;
        blueman.enable = true;
        pipewire = {
            enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
            pulse.enable = true;
        };
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
            pulseaudio = true;
        };
    };

# Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    services.flatpak.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.falastus = {
        isNormalUser = true;
        description = "falastus";
        extraGroups = [  "root" "networkmanager" "wheel" "docker" "ubridge" ];
        packages = with pkgs; [];
    };

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        pkgs.xorg.libX11
            pkgs.xorg.libXext
            pkgs.xorg.libXinerama
            pkgs.xorg.libXrandr
            pkgs.xorg.libXcursor
            pkgs.libGL
            pkgs.alsa-lib
            pkgs.libpulseaudio
    ];

# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
            neovim
            lunarvim
            obsidian
            wget
            firefox
            dmenu
            pulseaudioFull
            rofi
            unrar
            unzip
            feh
            flatpak
            superTuxKart
            dwarf-fortress
            picom
            htop
            pavucontrol
            yarn
            playerctl
            #cli tools
            alacritty
            btop
            tree
            fzf
            bat

#wayland pkgs
            waybar
            eww
            dunst
            swww
            wofi
            starship
            hyprlock
            hypridle
            hyprshot
#misc
            cava
            discord
            gimp
            libreoffice-qt6-fresh
            neofetch
            spotify
            dolphin-emu
            ];

    fonts.packages = with pkgs; [
        nerdfonts
    ];

# Docker setup
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };


# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

# List services that you want to enable:

# Enable the OpenSSH daemon.
    services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?

        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
                dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
                localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            ll = "ls -l";
            update = "sudo nixos-rebuild switch";
            egcc = "gcc -std=c99 -pedantic -Wall -Wextra -Wvla -Werror";
        };
    };
    users.defaultUserShell = pkgs.zsh;

#  security.wrappers.ubridge = {
#    source = “/home/falastus/.nix-profile/bin/ubridge”;
#    capabilities = “cap_net_admin,cap_net_raw=ep”;
#    owner = “root”;
#    group = “ubridge”;
#    permissions = “u+rx,g+x”;
#  };

}
