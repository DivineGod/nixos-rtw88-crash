{
  config,
  pkgs,
  lib,
  ...
}:
{
  system.stateVersion = "25.11";

  networking.hostName = "nanopc";
  zramSwap.enable = true;

  networking.wireless = {
    enable = true;
  };


  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "lo";
      WIFI_IFACE = "wlP3p49s0";
      SSID = "poc";
      PASSPHRASE = "1234567890";
    };
  };

  networking.wireless.interfaces = [ "wlP3p49s0" ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  users.users.poc = {
    isNormalUser = true;
    home = "/home/poc";
    description = "POC User";
    extraGroups = [ "wheel" ];

    password = "poc";
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Automatically log in at the virtual consoles.
  services.getty.autologinUser = "poc";

  nixpkgs.config.allowUnfree = true;
}
