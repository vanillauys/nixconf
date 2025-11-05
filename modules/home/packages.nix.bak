{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # CLI tools
    eza
    zoxide
    starship
    delta
    gum
    xclip
    btop
    alejandra
  ];

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      truecolor = true;
      vim_keys = false;
      rounded_corners = true;
      update_ms = 2000;
      proc_sorting = "cpu lazy";
      proc_colors = true;
      proc_gradient = true;
      show_uptime = true;
      show_cpu_freq = true;
    };
  };

  catppuccin.btop = {
    enable = true;
    flavor = "mocha";
  };
}
