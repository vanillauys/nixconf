{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "wihanuys";
        email = "wihan@glydepay.io";
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGq0FGHoWH5E4m5IMNOVMMcIZ5DYlumycAH2F7osvsO6";
      };

      gpg = {
        format = "ssh";
        ssh.program = "/opt/1Password/op-ssh-sign";
      };
      commit = {
        gpgsign = true;
      };
      push = {
        autoSetupRemote = true;
      };
      core = {
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;
        dark = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
    };
  };

  catppuccin.delta = {
    enable = true;
    flavor = "mocha";
  };
}
