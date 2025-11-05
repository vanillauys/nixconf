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

    ides = lib.mkEnableOption "enable IDEs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Version control and tools
      git
      gh

      # Compilers and build tools
      gcc
      clang
      gradle

      # Languages
      python3
      nodejs
      yarn
      rustc
      cargo
      go
      temurin-bin
      bun

      # Python package manager
      poetry

      # Development tools
      obsidian
      postman
      slack
    ] ++ lib.optionals cfg.ides [
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      jetbrains.webstorm
    ];
  };
}
