{ config, pkgs, ... }:
let 
  aliases = {
    # ls = "eza --long --no-time --no-user --no-permissions --group-directories-first --icons";
    ls = "eza --long --no-time --group-directories-first --icons";
    lg = "lazygit";

    hc = "nvim /home/dave/.dotfiles/home.nix";
    hs = "home-manager switch --flake /home/dave/.dotfiles && hyprctl reload";
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
    ags
    jq
    fastfetch
    eza
    yazi
    rofi-wayland
    pywal
    lazygit
    trash-cli
    waybar
    dunst

    # Dev bits
    nodePackages."live-server"
    hugo

    lua-language-server
    nodePackages.typescript-language-server
  ];

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  home.file = {
    ".config/hypr/hyprland.conf".source = hypr/hyprland.conf;
    ".config/foot/foot.ini".source = foot/foot.ini;
    ".config/fastfetch/config.jsonc".source = fastfetch/config.jsonc;
  };

  # xdg.configFile.nvim = {
  #   source = ./nvim;
  #   recursive = true;
  # };

  xdg.configFile.wal = {
    source = ./wal;
    recursive = true;
  };

  xdg.configFile.yazi.source = ./yazi;

  home.sessionVariables = {
    EDITOR = "nvim";
    WALLHAVEN_API = "XXMiYVopgEjJlslkFOWxkmbdM1k4nGEi";
    WALLHAVEN_USER = "fatnic";
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
      fastfetch
      # eval "$(zellij setup --generate-auto-start zsh)"
    '';
    shellAliases = aliases;
    oh-my-zsh = {
      enable = true;
      plugins = [];
      theme = "eastwood";
    };
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
