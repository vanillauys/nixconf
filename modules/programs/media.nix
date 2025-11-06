{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.media;
in {
  options.programs.media = {
    enable = mkEnableOption "media applications and codecs";

    players = mkOption {
      type = types.listOf (types.enum ["vlc" "mpv" "all"]);
      default = ["all"];
      description = "Media players to install";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      (optionals (elem "vlc" cfg.players || elem "all" cfg.players) [vlc])
      ++ (optionals (elem "mpv" cfg.players || elem "all" cfg.players) [mpv]);

    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };
}
