{ config, lib, pkgs, ... }:

{
  # AI and language model services
  services.ollama = {
    enable = true;
    loadModels = [ 
      "llama3.2:3b" 
      "deepseek-r1:1.5b"
    ];
  };
}
