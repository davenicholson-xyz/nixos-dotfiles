# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

# Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    services.nfs = {
      server.enable = true;
    };

  fileSystems."/mnt/media" = {
    device = "172.16.69.69:/export/media";
    fsType = "nfs";
  };

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
  networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "Europe/London";

# Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

# Configure keymap in X11
  services.xserver = {
    xkb.layout = "gb";
#xkbVariant = "";
  };

# Configure console keymap
  console.keyMap = "uk";

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dave = {
    isNormalUser = true;
    description = "Dave Nicholson";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

# Enable automatic login for the user.
  services.getty.autologinUser = "dave";

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
	# command = "Hyprland";
	command = "/home/dave/.dotfiles/scripts/hyprlauncher";
	user = "dave";
      };
      default_session = initial_session;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.setPath.enable = true;
  };

# programs.steam = {
#   enable = true;
#   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
#     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#     localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
# };

# services.xserver.enable = true;
# services.xserver.displayManager.sddm.enable = true;
# services.xserver.desktopManager.plasma6.enable = true;

# services.xserver = {
#   enable = true;
#   displayManager.gdm.enable = true;
#   desktopManager.gnome.enable = true;
# };

  services.expressvpn.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  hardware = {
    graphics.enable = true;
  };

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    noto-fonts
      noto-fonts-emoji
      roboto
      (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    unzip
      libnotify
      bash
      killall
      xsel
      xclip
      fd
      nerdfonts
      ripgrep
      font-awesome
      git
      gcc
      kitty
      foot
      btop
      gruvbox-gtk-theme
      adwaita-icon-theme	 
      expressvpn
      scummvm

      nodejs
      nodePackages.typescript-language-server
      # qtwayland5
      ];

  programs.zsh.enable = true;
  users.users.dave.shell = pkgs.zsh;

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

# Open ports in the firewall.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 
    8080 # live-server
  ]; 
  networking.firewall.allowedUDPPorts = [ 
    5353 # catt
  ]; 
  # networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 60999; } ];

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
