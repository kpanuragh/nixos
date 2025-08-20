{ config, lib, pkgs, ... }:

{
  # SSH configuration
  services.openssh = {
    enable = true;
    settings = {
      PubkeyAcceptedAlgorithms = "ssh-rsa,ssh-ed25519,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256,rsa-sha2-512,rsa-sha2-256";
      
      KexAlgorithms = [
        "mlkem768x25519-sha256"
        "sntrup761x25519-sha512"
        "sntrup761x25519-sha512@openssh.com"
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group-exchange-sha256"
        "diffie-hellman-group1-sha1"
      ];
      
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
        "aes128-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-ctr"
        "3des-cbc"
      ];
    };
  };
}
