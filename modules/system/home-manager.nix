{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.system.home-manager;
in {
  options.system.home-manager = {
    enable = lib.mkEnableOption "enable home-manager";

    userName = lib.mkOption {
      default = "wihan";
      description = "username for home-manager";
    };

    development = {
      enable = lib.mkEnableOption "enable development packages for home-manager";

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
    };

    ides = {
      enable = lib.mkEnableOption "enable IDEs for home-manager";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "${cfg.userName}" = {
          imports = [
            ../../home.nix
            {
              programs.development = {
                enable = cfg.development.enable;
                ides = cfg.ides.enable;
                cloud = cfg.development.cloud;
                communication = cfg.development.communication;
                languages = cfg.development.languages;
              };
            }
          ];
        };
      };
    };
  };
}
