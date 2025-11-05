{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.onepassword;
in {
  options.programs.onepassword = {
    enable = mkEnableOption "1Password";

    gui = mkOption {
      type = types.bool;
      default = true;
      description = "Enable 1Password GUI";
    };

    polkitPolicyOwners = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of users for polkit policy";
    };
  };

  config = mkIf cfg.enable {
    programs._1password.enable = true;
    programs._1password-gui = mkIf cfg.gui {
      enable = true;
      polkitPolicyOwners = cfg.polkitPolicyOwners;
    };
  };
}
