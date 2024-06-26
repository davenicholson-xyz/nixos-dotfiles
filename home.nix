{ config, pkgs, ... }:
let 
  aliases = {
    # ls = "eza --long --no-time --no-user --no-permissions --group-directories-first --icons";
    ls = "eza --long --no-time --group-directories-first --icons";
    lg = "lazygit";
  };
in {
  home.username = "dave";
  home.homeDirectory = "/home/dave";

  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
    google-chrome
    swww
    ags
    jq
    fastfetch
    eza
    yazi
    pywal
    lazygit
    trash-cli
    waybar
  ];

  home.file = {
    ".config/hypr/hyprland.conf".source = hypr/hyprland.conf;
    ".config/foot/foot.ini".source = foot/foot.ini;
    ".config/yazi/yazi.toml".source = yazi/yazi.toml;
    ".config/yazi/keymap.toml".source = yazi/keymap.toml;
    ".config/yazi/theme.toml".source = yazi/theme.toml;
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    WALLHAVEN_API = "XXMiYVopgEjJlslkFOWxkmbdM1k4nGEi";
    WALLHAVEN_USER = "fatnic";
  };

  home.sessionPath = [
    "/home/dave/.dotfiles/scripts"
  ];

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
    '';
    shellAliases = aliases;
    oh-my-zsh = {
      enable = true;
      plugins = [];
      theme = "eastwood";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
