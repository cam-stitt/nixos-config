{ config, pkgs, lib, ... }:

with lib;
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    newSession = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
        set -g @continuum-restore 'on'
        '';
      }
    ];
    extraConfig = ''
      # mouse on
      set -g mouse on
      # TODO: review if this is needed
      set -s set-clipboard off

      # alternative navigation
      bind -r k select-pane -D
      bind -r j select-pane -L
      bind -r i select-pane -U
      bind -r l select-pane -R

      # `y` will copy to system clipboard
      bind -T copy-mode y copy-pipe "xclip -sel clip -i"
      # we can make a selection using mouse, and it will copy
      # but not leave copy mode!
      bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe "xclip -sel clip -i" \; send -X clear-selection

      # vertical splits
      unbind g
      unbind C-g
      bind-key g split-window -h
      bind-key C-g split-window -h

      # horizontal splits
      unbind h
      unbind C-h
      bind-key h split-window
      bind-key C-h split-window

      # kill pane
      unbind C-w
      bind-key C-w kill-pane

      # COLOUR (base16)

      # default statusbar colors
      #set-option -g status-style "fg=#838184,bg=#323537"
      set-option -g status-style "fg=#000000,bg=#eaffff"

      # default window title colors
      #set-window-option -g window-status-style "fg=#838184,bg=default"
      set-window-option -g window-status-style "fg=#000000,bg=#eaffff"

      # active window title colors
      #set-window-option -g window-status-current-style "fg=#f9ee98,bg=default"
      set-window-option -g window-status-current-style "fg=#000000,bg=#eaffff"

      # pane border
      #set-option -g pane-border-style "fg=#323537"
      set-option -g pane-border-style "fg=#99994c"
      #set-option -g pane-active-border-style "fg=#464b50"
      set-option -g pane-active-border-style "fg=#99994c"

      # message text
      set-option -g message-style "fg=#a7a7a7,bg=#323537"

      # pane number display
      #set-option -g display-panes-active-colour "#8f9d6a"
      #set-option -g display-panes-colour "#f9ee98"
      set-option -g display-panes-active-colour "#000000"
      set-option -g display-panes-colour "#eeee9e"

      # clock
      #set-window-option -g clock-mode-colour "#8f9d6a"
      set-window-option -g clock-mode-colour "#000000"

      # copy mode highligh
      set-window-option -g mode-style "fg=#838184,bg=#464b50"

      # bell
      set-window-option -g window-status-bell-style "fg=#323537,bg=#cf6a4c"
    '';
  };
}
