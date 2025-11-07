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
    home.sessionVariables = {
      GOOGLE_APPLICATION_CREDENTIALS = "${config.home.homeDirectory}/.config/gcloud/application_default_credentials.json";
      LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
        pkgs.stdenv.cc.cc.lib
        pkgs.libz
        pkgs.glibc
        pkgs.zlib
        pkgs.libgcc
      ]}";
    };
    home.packages = with pkgs;
      [
        # Version control and tools
        git
        gh

        # Compilers and build tools
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
        google-cloud-sdk
      ]
      ++ lib.optionals cfg.ides [
        jetbrains.idea-ultimate
        jetbrains.pycharm-professional
        jetbrains.webstorm
      ];
  };
}
