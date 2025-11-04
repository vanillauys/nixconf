{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.onepassword-shell-plugins.hmModules.default
  ];

  home.sessionVariables = {
    GOOGLE_APPLICATION_CREDENTIALS = "${config.home.homeDirectory}/.config/gcloud/application_default_credentials.json";
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.1password/agent.sock";
    EDITOR = "nvim";
    DISABLE_AUTO_TITLE = "true";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.bun/bin"
    "${config.home.homeDirectory}/.local/bin"
  ];

  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [
      gh
      google-cloud-sdk
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "history"
      ];
    };

    shellAliases = {
      ls = "eza --tree --level 1 --icons=always";
      vim = "nvim";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";

      # Dev aliases
      boot = "./gradlew bootRun";
      sa = "./gradlew --parallel spotlessApply";
      dbup = "docker compose -p \"paylabs-postgres\" -f ~/glyde/backend/cbs-api/docker/docker-compose.yml up -d";
      dbdn = "docker compose -p \"paylabs-postgres\" -f ~/glyde/backend/cbs-api/docker/docker-compose.yml down";
      fbranch = "git branch | cut -c 3- | gum filter | xargs -I {} git switch {}";
      ccbranch = "git branch | grep \"*\" | cut -c 3- | xclip";
      dbranch = "git branch | cut -c 3- | gum choose --no-limit | xargs -I {} git branch -D {}";
      fuckit = "reset --hard";
      git = "git";
      gw-build = "./gradlew build -xtest --continuous --parallel";
    };

    initContent = ''
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  catppuccin.zsh-syntax-highlighting = {
    enable = true;
    flavor = "mocha";
  };

  catppuccin.starship = {
    enable = true;
    flavor = "mocha";
  };

  catppuccin.fzf = {
    enable = true;
    flavor = "mocha";
  };
}
