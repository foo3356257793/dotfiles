# Desktop rice tickets

Palette: "Neon" (bg `#3A1160`, dim `#2A0C48`, alt `#4E1980`, pink `#FE53BB`,
cyan `#00FFCA`, yellow `#FFE700`, green `#23EE15`). Configs live in `rice/` in this repo, symlinked
into `~/.config` and `~/.local/share`; GTK palette is `rice/gtk-4.0/neon.css`.

System: Ubuntu 26.04, GNOME 50.1, Wayland. Plasma is also installed.

## Done

- [x] **R1 Clear leftovers** (2026-10-11). Removed the dead Unite import from
  `~/.config/gtk-3.0/gtk.css` and the Breeze `colors.css`, `settings.ini` and
  `gtk.default.css`. Originals in `~/.config/gtk-backup-2026-10-11/`.
- [x] **R3 Neon in apps** (2026-10-11). `~/.config/gtk-4.0/{neon.css,gtk.css}`
  recolour libadwaita; `gtk-3.0/gtk.css` imports the same palette; adw-gtk3
  v6.5 in `~/.local/share/themes`, `gtk-theme` set to `adw-gtk3-dark`.

- [x] **R2 Dark mode, accent, wallpaper** (2026-10-11). `color-scheme`
  `prefer-dark`, `accent-color` `pink`, wallpaper
  `~/Pictures/Wallpapers/neon-gradient.png` (generated placeholder gradient;
  swap for a real image any time).

- [x] **R5 Cursor** (2026-10-11). Bibata-Modern-Ice v2.0.7 in
  `~/.local/share/icons`, `cursor-theme` set to it.

- [x] **R4 Top panel and overview** (2026-10-11). Blur my Shell v74 at
  defaults (user: looks fine as is; chosen over Open Bar). Just Perfection v37
  with the Activities button hidden. Extension Manager installed.
- [x] **R7 Tiling** (2026-10-11). Skipped by choice.

- [x] **R6 Terminal** (2026-10-11). Ghostty 1.3 is the default terminal
  (no decorations, 85% opacity, starts maximized, blurred via Blur my Shell's
  application blur). Ctrl+Alt+Return runs
  `ghostty -e tmux new-session -A -s main`. fastfetch, btop (Neon theme), eza
  (`ls` alias in `zshrc`) and bat (`ansi` theme, linked from `batcat`)
  installed.
- [x] **R8 Follow-ups** (2026-10-11). Configs moved into `rice/`; titlebar
  pink aligned to `#FE53BB`; Neon editor scheme for gedit and Text Editor;
  GNOME Terminal header bar off and fallback titlebar hidden when maximized.

## Open

- [ ] **R9 Loose ends**
  - Emacs changes and `neon-purple-theme.el` in this repo are still
    uncommitted (not part of the rice commits).
  - `gtk.css` at the repo root is the old GTK3 file, superseded by
    `rice/gtk-3.0/gtk.css`; delete or keep.
  - GNOME Text Editor's Neon scheme was never load-tested; check it once.
  - Snap apps (Firefox, Spotify) do not read `~/.config/gtk-4.0`.
  - Logging into Plasma regenerates Breeze `settings.ini`/`colors.css` in
    `~/.config/gtk-{3,4}.0`.
  - Wallpaper is a generated placeholder gradient.
  - Optional: starship prompt, Ghostty ligatures, fastfetch layout.
  - Undo notes and old values: `~/.config/gtk-backup-2026-10-11/`.
