{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      arti
      # chatterino2 
      claws-mail
      elinks 
      element-desktop
      firefox-esr
      floorp
      inetutils
      librewolf
      # openssl 
      qutebrowser
      thunderbird
      termshark
      tor-browser
      v2ray
      vesktop
      w3m 
      weechat
      # weechatScripts.weechat-matrix-bridge
      # weechatScripts.weechat-matrix
      wget
      wireshark
    ];
  };
}
