{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.development;
in {
  options.programs.development = {
    enable = lib.mkEnableOption "enable development packages";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      gcc
      clang
      python3
      nodejs
      yarn
      rustc
      cargo
      go
      # Add more as needed
    ];
  };
}
