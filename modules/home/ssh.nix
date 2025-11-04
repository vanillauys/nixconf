{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    
    matchBlocks = {
      "*" = {
        extraOptions = {
          IdentityAgent = "~/.1password/agent.sock";
        };
      };
      
      "personalgit" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/personal_git.pub";
        identitiesOnly = true;
      };
      
      "glydegit" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/glyde_git.pub";
        identitiesOnly = true;
      };
    };
  };

  home.file = {
    ".ssh/glyde_git.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGq0FGHoWH5E4m5IMNOVMMcIZ5DYlumycAH2F7osvsO6
    '';

    ".ssh/personal_git.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHO2hJGXjw6X1fLPgwr9eP7F0luBsCrMMCJ3LOzqDbP
    '';
  };
}
