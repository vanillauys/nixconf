{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.hardware.audio;
in {
  options.hardware.audio = {
    enable = mkEnableOption "audio configuration";

    backend = mkOption {
      type = types.enum ["pipewire" "jack"];
      default = "pipewire";
      description = "Audio backend to use";
    };

    support32Bit = mkOption {
      type = types.bool;
      default = true;
      description = "Enable 32-bit ALSA support";
    };
  };

  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = cfg.support32Bit;
      pulse.enable = true;
      jack.enable = cfg.backend == "jack";
    };
  };
}
