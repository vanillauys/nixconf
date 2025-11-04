{
  config,
  pkgs,
  ...
}: {
  programs.brave = {
    enable = true;
  };

  catppuccin.brave = {
    enable = true;
    flavor = "mocha";
  };
}
