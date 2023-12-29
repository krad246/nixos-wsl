{pkgs, ...}: {
  environment = {
    systemPackages = pkgs.callPackage ./package-list.nix {};
    shells = with pkgs; [zsh nushell];
  };

  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };

    nix-index = {
      enable = false;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
