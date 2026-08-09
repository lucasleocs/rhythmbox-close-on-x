# Rhythmbox Close on X

A tiny Rhythmbox plugin that makes the window **X** button actually quit Rhythmbox instead of leaving the application running in the background.

## Quick installation

For the easiest installation, download the latest release:

**[Download Close on X](https://github.com/lucasleocs/rhythmbox-close-on-x/releases/latest/download/close-on-x-plugin.zip)**

1. Extract `close-on-x-plugin.zip`.
2. Copy the `close-on-x` folder to:

```text
~/.local/share/rhythmbox/plugins/
```

The final location should be:

```text
~/.local/share/rhythmbox/plugins/close-on-x/
├── close-on-x.plugin
└── close-on-x.py
```

If you use a graphical file manager such as Nemo, press **Ctrl+H** to show hidden folders, then open:

```text
.local -> share -> rhythmbox -> plugins
```

Create the `plugins` folder if it does not already exist.

3. Open Rhythmbox.
4. Open **Menu -> Plugins**.
5. Enable **Close on X**.

Restart Rhythmbox if the plugin does not appear immediately.

## Why

On some Linux desktop setups, closing the Rhythmbox window hides it while the Rhythmbox process continues running.

This plugin detects when the main window is hidden after closing it and requests Rhythmbox's normal application shutdown.

The goal is simple:

```text
Click X
  -> Rhythmbox window closes
  -> Rhythmbox quits completely
  -> no Rhythmbox process remains in the background
```

## Tested on

* Linux Mint 22.3 (Zena)
* Rhythmbox 3.4.7
* X11

It may work on other Rhythmbox 3.4.x/Linux setups, but those have not been tested yet.

## Other installation methods

### Clone with Git

```bash
mkdir -p ~/.local/share/rhythmbox/plugins
git clone https://github.com/lucasleocs/rhythmbox-close-on-x.git \
  ~/.local/share/rhythmbox/plugins/close-on-x
```

Then open Rhythmbox and enable:

**Menu -> Plugins -> Close on X**

### Use the installer script

Clone or download this repository, then from inside its directory run:

```bash
chmod +x install.sh
./install.sh
```

Then enable **Close on X** in Rhythmbox.

## Verify that it works

1. Open Rhythmbox.
2. Start playing audio.
3. Click the window **X** button.
4. Run:

```bash
pgrep -af rhythmbox || echo "Rhythmbox really exited"
```

If the plugin is working, no Rhythmbox process should remain.

## Uninstall

For a graphical uninstall, close Rhythmbox and delete:

```text
~/.local/share/rhythmbox/plugins/close-on-x
```

Or use the terminal:

```bash
rm -rf ~/.local/share/rhythmbox/plugins/close-on-x
```

If you installed from a copy of this repository, you can also run:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

Restart Rhythmbox afterward.

## How it works

Rhythmbox plugins use libpeas. This plugin connects to the main window's `hide` signal.

On the tested setup, clicking the window **X** causes Rhythmbox to hide its main window while leaving the application running. When this happens, the plugin calls Rhythmbox's normal shell quit method:

```python
self.object.quit()
```

A small guard prevents the shutdown path from being requested more than once.

Minimizing Rhythmbox or placing another window in front of it does not trigger this behavior.

## Notes

* This plugin intentionally changes the behavior of the window **X** button.
* It does not add a background service, daemon, systemd unit, or PPA.
* It only installs files in the current user's Rhythmbox plugin directory.
* If you prefer Rhythmbox to remain available in the background after closing the window, do not use this plugin.

## Troubleshooting

If **Close on X** does not appear in the plugin list, first verify the files:

```bash
find ~/.local/share/rhythmbox/plugins/close-on-x -maxdepth 1 -type f -print
```

Check Python syntax:

```bash
python3 -m py_compile \
  ~/.local/share/rhythmbox/plugins/close-on-x/close-on-x.py
```

And inspect recent Rhythmbox/libpeas messages:

```bash
journalctl --user -b --no-pager |
grep -iE 'rhythmbox|peas|close-on-x' |
tail -80
```

## License

MIT. See [LICENSE](LICENSE).
