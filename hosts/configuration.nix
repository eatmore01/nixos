{
  config,
  pkgs,
  lib,
  vars,
  home-manager,
  host,
  ...
}:
let
  hostSetup = ./${host};
  procArch = if vars.procArch == "intel" then "kvm-intel" else "kvm-amd";
in
{
  imports = [
    ./hardware-configuration.nix
    ../drivers
    ../virtualisation
    ../services
    ../programs
    ../wms
    hostSetup
  ];

  system.stateVersion = vars.stateVersion;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    kernelModules = [
      procArch # enable virtualization on core level
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Asia/Irkutsk";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  networking = {
    hostName = vars.hostname;
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # system utils
    udisks2
    unzip
    zip
    dnsutils
    htop
    btop
    git
    wget
    usbutils
    file
    nixfmt
    # audio
    pipewire

    # login manager
    greetd # or greetd.greetd with stable chanel
    # filemanager
    nautilus
    # sound manager
    pavucontrol
    # apps
    google-chrome
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  drivers.intel.enable =
    if vars.gpu.intel.enable && vars.gpu.nvidia.enable == false then true else false;

  drivers.nvidia.enable =
    if vars.gpu.nvidia.enable && vars.gpu.intel.enable == false then true else false;
}
