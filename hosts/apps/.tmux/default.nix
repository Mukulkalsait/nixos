{ lib, config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    extraConfig = ''
      # Set prefix to Ctrl+t (like Zellij's tab mode)
      set -g prefix C-t
      unbind C-b
      bind C-t send-prefix

      # Theme (Catppuccin Mocha to match Kitty/Ghostty)
      set -g status-style bg=#1e1e2e,fg=#cdd6f4
      set -g pane-border-style fg=#45475a
      set -g pane-active-border-style fg=#89b4fa

      # Mouse support (like Zellij)
      set -g mouse on

      # Vi mode for copy-mode (for search/scroll)
      set -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Zellij-like keybindings
      # Ctrl+t n: New window (tab)
      bind -T prefix n new-window -c "#{pane_current_path}"

      # Ctrl+b ", %: Split pane (down, right; Zellij uses tmux defaults)
      bind "\"" split-window -v -c "#{pane_current_path}"
      bind "%" split-window -h -c "#{pane_current_path}"

      # Alt+h/j/k/l: Navigate panes (and windows for tabs)
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R
      bind -n M-h previous-window  # Also navigate windows (tabs)
      bind -n M-l next-window

      # Ctrl+g: Lock session
      bind -n C-g lock-session

      # Ctrl+q: Quit session
      bind -n C-q confirm-before -p "Kill session #S? (y/n)" kill-session

      # Ctrl+s: Enter copy-mode for search, u/d to scroll
      bind -n C-s copy-mode
      bind -T copy-mode-vi C-u send-keys -X halfpage-up
      bind -T copy-mode-vi C-d send-keys -X halfpage-down
      bind -T copy-mode-vi u send-keys -X cursor-up
      bind -T copy-mode-vi d send-keys -X cursor-down
      bind -T copy-mode-vi / command-prompt -p "search down" "send-keys -X search-forward '%%'"
      bind -T copy-mode-vi ? command-prompt -p "search up" "send-keys -X search-backward '%%'"

      # Alt+p: Toggle floating pane (approximated with zoom)
      bind -n M-p resize-pane -Z

      # Ctrl+n: Enter resize mode, h/j/k/l to resize
      bind -n C-n resize-pane -Z \; display "Resize: h/j/k/l"
      bind -T prefix h resize-pane -L 5
      bind -T prefix j resize-pane -D 5
      bind -T prefix k resize-pane -U 5
      bind -T prefix l resize-pane -R 5

      # Ctrl+h: Move pane (approximates floating pane movement)
      bind -n C-h swap-pane -s :+.top \; select-pane -t :.+

      # Reload config
      bind r source-file ~/.tmux.conf \; display "Reloaded!"
    '';
  };
}
