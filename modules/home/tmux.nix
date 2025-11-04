{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    mouse = true;
    keyMode = "vi";
    
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm-*:Tc"
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi C-v send -X rectangle-toggle
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      bind '"' split-window -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"
    '';

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      vim-tmux-navigator
      yank
    ];
  };

  catppuccin.tmux = {
    enable = true;
    flavor = "mocha";
  };
}
