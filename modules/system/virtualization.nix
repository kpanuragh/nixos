{ config, lib, pkgs, ... }:

{
  # Virtualization services
  virtualisation = {
    # Docker configuration
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [ "--all" ];
      };
      daemon.settings = {
        features = { buildkit = true; };
        exec-opts = [ "native.cgroupdriver=systemd" ];
        log-driver = "journald";
        storage-driver = "overlay2";
      };
    };
    
    # Waydroid for Android apps
    waydroid.enable = true;
  };
}
