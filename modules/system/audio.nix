{ config, lib, pkgs, ... }:

{
  # Audio configuration with PipeWire
  services.pulseaudio.enable = false;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # Enable JACK support for pro audio
    wireplumber.enable = true;
    
    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024; # Lower latency
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 4096;
        "core.daemon" = true;
        "core.name" = "pipewire-0";
      };
      
      "context.modules" = [
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-profiler"; }
        { name = "libpipewire-module-metadata"; }
        { name = "libpipewire-module-spa-device-factory"; }
        { name = "libpipewire-module-spa-node-factory"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-client-device"; }
        { name = "libpipewire-module-adapter"; }
        { name = "libpipewire-module-link-factory"; }
        { name = "libpipewire-module-session-manager"; }
      ];
    };
  };
}
