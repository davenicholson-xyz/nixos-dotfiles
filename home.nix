{ config, pkgs, ... }:
let 
aliases = {
  ls = "eza --long --no-time --group-directories-first --icons";
  lg = "lazygit";
  cat = "bat";
  cd = "z";

  nc = "nvim /home/dave/.dotfiles/configuration.nix";
  ns = "sudo nixos-rebuild switch --flake /home/dave/.dotfiles";
  hc = "nvim /home/dave/.dotfiles/home.nix";
  hs = "home-manager switch --impure --flake /home/dave/.dotfiles && hyprctl reload";
  hyp = "nvim /home/dave/.dotfiles/hypr";

  wallc = "xdg-open $(wallhaven -u)";
};
in {
  home.username = "dave";
  home.homeDirectory = "/home/dave";

  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
      google-chrome
      cinnamon.nemo
      swww
      waypaper
      jq
      bat
      fastfetch
      eza
      yazi
      rofi-wayland
      pywal
      lazygit
      trash-cli
      waybar
      ags
      swaynotificationcenter
      networkmanagerapplet
      grim
      slurp
      streamlink
      mpv
      catt
      zsh-history-substring-search
      eyedropper

# Dev bits
      nodePackages."live-server"
      hugo

# Neovim required
      lua-language-server
      nodePackages.typescript-language-server
      ];

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  home.file = {
    ".config/foot/foot.ini".source = foot/foot.ini;
    ".config/fastfetch/config.jsonc".source = fastfetch/config.jsonc;
  };

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/dave/.dotfiles/nvim";
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/dave/.dotfiles/hypr";
  home.file.".config/systemd/user".source = config.lib.file.mkOutOfStoreSymlink "/home/dave/.dotfiles/systemd";

  xdg.configFile.wal = {
    source = ./wal;
    recursive = true;
  };

  xdg.configFile.yazi.source = ./yazi;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "/home/dave/.dotfiles/scripts"
  ];

  programs.direnv.enable = true;

  programs.git = {
    enable = true;
    userName = "Dave Nicholson";
    userEmail = "me@davenicholson.xyz";
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      cat /home/dave/.cache/wal/sequences
      '';
    shellAliases = aliases;
    enableCompletion = true;
    history = {
      size = 10000;
    };
    oh-my-zsh = {
      enable = true;
      theme = "eastwood";
      plugins = [
        "git"
        "history"
        "zoxide"
      ];
    };
  };

  # programs.oh-my-posh = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile oh-my-posh/myspace.json));
  # };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zellij.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
