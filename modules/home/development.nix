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

    languages = {
      python = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Python development tools";
      };

      java = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Java development tools";
      };

      javascript = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable JavaScript/Node.js development tools";
      };

      c = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable C/C++ development tools";
      };

      rust = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Rust development tools";
      };

      terraform = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Terraform";
      };
    };

    cloud = {
      gcloud = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Google Cloud SDK";
      };

      aws = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable AWS CLI";
      };
    };

    communication = {
      slack = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Slack";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      GOOGLE_APPLICATION_CREDENTIALS = lib.mkIf cfg.cloud.gcloud "${config.home.homeDirectory}/.config/gcloud/application_default_credentials.json";
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

        # General development tools
        obsidian
        postman
      ]
      # Language-specific packages
      ++ lib.optionals cfg.languages.python [
        python3
        poetry
      ]
      ++ lib.optionals cfg.languages.java [
        gradle
        temurin-bin
      ]
      ++ lib.optionals cfg.languages.javascript [
        nodejs
        yarn
        bun
      ]
      ++ lib.optionals cfg.languages.c [
        clang
        gcc
      ]
      ++ lib.optionals cfg.languages.rust [
        rustc
        cargo
      ]
      ++ lib.optionals cfg.languages.terraform [
        terraform
      ]
      # Cloud tools
      ++ lib.optionals cfg.cloud.gcloud [
        google-cloud-sdk
      ]
      ++ lib.optionals cfg.cloud.aws [
        awscli2
      ]
      # Communication
      ++ lib.optionals cfg.communication.slack [
        slack
      ]
      # IDEs
      ++ lib.optionals cfg.ides [
        jetbrains.idea-ultimate
        jetbrains.pycharm-professional
        jetbrains.webstorm
      ];
  };
}
