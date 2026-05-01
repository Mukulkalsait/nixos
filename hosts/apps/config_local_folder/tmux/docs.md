
Let me break this into 3 parts.

---

## 1. Important commands you should know

```
Prefix = Ctrl+g

# Sessions
Ctrl+g d          — detach (you lost this, rebind below)
Ctrl+g $          — rename session
Ctrl+g s          — list/switch sessions (interactive)

# Windows
Ctrl+g n          — new window (your bind)
Ctrl+g ,          — rename window
Ctrl+g w          — visual window list
Ctrl+g &          — kill window (default, you have Ctrl+g x)

# Panes
Ctrl+g r          — split horizontal (your bind)
Ctrl+g d          — split vertical (your bind) ← CONFLICT with detach!
Ctrl+g z          — zoom pane fullscreen toggle
Ctrl+g q          — show pane numbers
Ctrl+g {          — swap pane left
Ctrl+g }          — swap pane right
Ctrl+g !          — break pane into new window
Ctrl+g Space      — cycle layouts

# Copy mode
Ctrl+g [          — enter copy mode (vim keys since mode-keys vi)
Ctrl+g ]          — paste buffer

# Misc
Ctrl+g :          — command prompt
Ctrl+g ?          — list ALL keybindings
Ctrl+g t          — clock
```

You have a conflict — `bind d` is both your `split-window -v` AND the default detach. Fix by adding detach back on a free key in `keys.conf`:

```conf
bind D detach-client    # Ctrl+g D to detach
```

---

## 2. All menu-opening bindings

That `<` menu you found is a pane menu. Here's every built-in menu:

```
Ctrl+g <          — pane menu (what you found)
Ctrl+g >          — window menu  
Ctrl+g Space      — next layout menu
Ctrl+g '          — select window by index (prompt)

# From command prompt (Ctrl+g :)
display-menu      — you can trigger any menu manually
```

You can also make your own custom menus — very powerful. Add these to `keys.conf`:

```conf
# Custom session menu on Ctrl+g S
bind S display-menu -T "#[bold]Sessions" \
    "New Session"        n "new-session" \
    "Kill Session"       k "kill-session" \
    "Rename Session"     r "command-prompt -I '#S' 'rename-session %%'" \
    "Detach"             d "detach-client" \
    ""                   "" "" \
    "List Sessions"      l "choose-session"

# Custom pane menu on Ctrl+g P
bind P display-menu -T "#[bold]Panes" \
    "Split Right"        r "split-window -h" \
    "Split Down"         d "split-window -v" \
    "Zoom Toggle"        z "resize-pane -Z" \
    "Break to Window"    b "break-pane" \
    "Kill Pane"          x "kill-pane" \
    ""                   "" "" \
    "Swap Up"            k "swap-pane -U" \
    "Swap Down"          j "swap-pane -D"
```

---

## 3. Floating pane — bottom right, 50% wide

```
Screen divided into:
┌─────────────┬─────────────┐
│             │      1      │
│             ├─────────────┤
│    LEFT     │      2      │
│             ├─────────────┤
│             │  3 ← float  │
└─────────────┴─────────────┘
```

Replace your current `M-p` binding in `keys.conf`:

```conf
bind -n M-p if-shell "[ $(tmux list-panes | wc -l) -eq 1 ]" \
  "split-window -h -p 50 \; split-window -v -p 33" \
  "resize-pane -Z"
```

What this does:
- First press → splits right 50% wide, then splits that right pane's bottom 33% → gives you exactly the bottom-right block
- Second press → zooms it fullscreen (your existing toggle behavior)
- `Alt+p` again → unzooms back to the layout

The `[[ ]]` was also a bash-ism that can cause issues in tmux — changed to `[ ]` which is safer.
