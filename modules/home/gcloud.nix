{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    google-cloud-sdk
  ];

  home.sessionVariables = {
    GOOGLE_APPLICATION_CREDENTIALS = "${config.home.homeDirectory}/.config/gcloud/application_default_credentials.json";
  };
}
