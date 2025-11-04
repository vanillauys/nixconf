{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "za";
      variant = "";
    };
  };
  services.libinput.enable = true;
}
