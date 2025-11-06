{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.packages;
in {
  options.programs.packages = {
    enable = mkEnableOption "system packages";

    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional packages to install";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        # editors
        vim
        nano
        # terminal multiplexer
        tmux
        # network
        wget
        curl
        rsync
        # version control
        git
        # archive utilities
        zip
        unzip
        gzip
        bzip2
        xz
        p7zip
        unrar
        # file management
        tree
        file
        which
        # system info
        fastfetch
        htop
        lsof
        pciutils
        usbutils
        # text processing
        ripgrep
        fd
        bat
        jq
        # performance
        ananicy-rules-cachyos
        # process management
        killall
        psmisc
      ]
      ++ cfg.extraPackages;
  };
}
