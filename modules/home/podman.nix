{ config, pkgs, ... }:

{
  # User-scoped registry configuration
  xdg.configFile."containers/registries.conf".text = ''
    [registries.search]
    registries = ['docker.io']
  '';
}
