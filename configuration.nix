{ config, pkgs, ... }:

{
  system.stateVersion = "25.11";

  imports = [
      ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "seiversiana-nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Manila";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.seiversiana = {
    isNormalUser = true;
    description = "Nile Jocson";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
 
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    clang
    clang-tools
    cmake
    vim
    tmux
    brightnessctl
    lxsession
    tree
  ];

  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  services.openssh.enable = true;

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  services.displayManager.ly.enable = true;

  programs.steam.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [ thunar-archive-plugin ];
  };

  services.gvfs.enable = true; 

  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };
}
