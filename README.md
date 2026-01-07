<p align="center">
    <img width="200px" src="https://i.imgur.com/TU66AEL.png">
</p>

#
<p align="center">
        <img src="https://img.shields.io/badge/version-v4.0.0-F0544C?style=for-the-badge">
        <img src="https://img.shields.io/github/v/tag/simonvic/dotfiles?color=F0544C&label=latest%20stable%20release&style=for-the-badge">
        <br>
        <br>
        <img src="https://img.shields.io/github/last-commit/simonvic/dotfiles/dev?color=F0544C&logoColor=F0544C&style=flat-square">
        <img src="https://img.shields.io/github/commits-since/simonvic/dotfiles/latest/dev?color=F0544C&logoColor=F0544C&style=flat-square">
        <br>
        <img src="https://img.shields.io/github/repo-size/simonvic/dotfiles?color=F0544C&logoColor=F0544C&style=flat-square">    
        <img src="https://img.shields.io/github/license/simonvic/dotfiles?color=F0544C&style=flat-square">
        <br>
        <img src="https://img.shields.io/github/watchers/simonvic/dotfiles?color=F0544C&style=flat-square">
        <img src="https://img.shields.io/github/forks/simonvic/dotfiles?color=F0544C&style=flat-square">
</p>


# Getting started

This is my personal setup that I use to quickly bootstrap my machines with a
single `git clone`.

It targets Linux systems, but can also be used on WSLs, systems with just TTY,
and Android (via Termux).

In `.config` there are the configuration files for: shell prompt, terminal,
windows manager, status bars, lockscreen, notification daemon, application
launchers, fonts, general theming and more.

In `.local/bin` there are a bunch of bash scripts which wrap the many utilities
used and aims to improve interoperability between them, while providing some
QoL features on top.

In `.config/nvim` there is my heavily customized neovim setup, with custom
colorscheme, custom keybindings and other customizations.

## X11 to Wayland

Since the 4.0 release, I target Wayland based systems; although the scripts
should be compatible with both X11 and Wayland, X11 side of the dotfiles should
be considered unmaintained, and Wayland should be preferred

Here is a list of the Wayland packages that replaced their X11 counterpart:

| Utility           | X11                        | Wayland                          |
| ----------------- | -------------------------- | -------------------------------- |
| Status bar        | polybar                    | waybar                           |
| Window manager    | i3wm                       | swayvm (swayfx fork)             |
| Window compositor | picom                      | included in swayfx               |
| Lockscreen        | i3lock (i3lock-color fork) | swaylock (swaylock-effects fork) |
| Night mode        | redshift                   | gammastep                        |
| Screenshots       | scrot                      | grim + slurp                     |

<br>

## Quickstart

> [!WARNING]
> Before proceeding to installation make sure to backup your system

1. Install the required packages

1. Clone the dotfiles
	
	```bash
	git clone --bare https://github.com/simonvic/dotfiles.git ${XDG_DATA_HOME:-$HOME/.local/share}/.dotfiles
	```

1. Checkout the content

	```bash
	git --git-dir=${XDG_DATA_HOME:-$HOME/.local/share}/.dotfiles/ --work-tree=$HOME checkout
	```

1. Hide the untracked files
	
	```bash
	git --git-dir=${XDG_DATA_HOME:-$HOME/.local/share}/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
	```

1. Add `.local/bin` to the `PATH` enviroment variable

	```bash
	echo '
	if [[ $UID -ge 1000 && -d $HOME/.local/bin && -z $(echo $PATH | grep -o $HOME/.local/bin) ]]; then
    	export PATH="${PATH}:$HOME/.local/bin"
	fi' >> /etc/profile
	```

1. Make the scripts executable (`chmod +x <script>`)

1. **Relog or reboot your system to make sure the changes have taken effect**

> [!TIP]
> Visit the [installation guide](https://github.com/simonvic/dotfiles/wiki/Installation)
> for a more in-depth guide.

<br>

# Showcase 

> [!NOTE]
> The previews may not be up to date with the latest changes


<h2 align="center">Lockscreen</h2>

<img src="https://i.imgur.com/1xyHtuH.gif" width="100%">

<details>
<summary>Other themes preview</summary>
<img src="https://imgur.com/AD6SStG.gif" width="50%">
<img src="https://imgur.com/t9re5NI.gif" width="50%">
</details>

<br>

<h2 align="center">Application launcher, window switcher and calculator (Rofi)</h2>

<img src="https://imgur.com/iU7AKT8.gif" width="100%">

Rofi themes have been made to be easily configurable and customized. The
configuration files and themes are structured like this:

```
|_ config            (defines rofi behaviour, components and default base UI layout/structure)
|_ Theme             (defines UI layout and structure)
    |_ Style         (defines UI components color and text font)
        |_ Fonts     (defines a set of fonts)
        |_ Palette   (defines a color palette)
```

A `Theme` (e.g. *fullscreen.rasi*, *reverse.rasi*, *window_reverse.rasi* etc)
only takes care of how the UI components are structured and arranged. It
imports a `Style`.

A `Style` defines text fonts, imported from a `Fonts`, and the colors of the
components, imported from a `Palette`

<br>

<h2 align="center">Status bars</h2>

[sPolybarctl](https://github.com/simonvic/dotfiles/wiki/Scripts#spolybarctl)
will manage your status bars. It can `launch`, `show`, `hide` or `toggle` them.

```shell-session
$ sPolybarctl show myFirstBar    # make visible "myFirstBar"
$ sPolybarctl toggle mySecondBar # toggle visibility state for "mySecondBar"
$ sPolybarctl hide               # hide all bars
```

<img src="https://imgur.com/rNcoOSk.gif" width="100%">

<br>

<h2 align="center">TODO manager,Notifications and more (Dunst) </h2>

<h3 align="center">Music control (sPlayerctl) + custom Spotify notification</h3>

[sPlayerctl](https://github.com/simonvic/dotfiles/wiki/Scripts#splayerctl)
helps you in controlling your media players

<img src="https://imgur.com/kFvlW6i.gif" width="100%">

A great QoL feature is the quick selection of the player you wish to control
(via CLI or via media keys)

```shell-session
$ sPlayerctl select-player set spotify
```

...or even better prompt the selection with a UI via `Dunst` and `Rofi`

<img src="https://imgur.com/7aRCUr3.gif" width="100%">

<h3 align="center">App notifications</h3>

<img src="https://imgur.com/nVk0GU6.gif" width="100%">

<br>

<h3 align="center">WiFi</h3>

With [sWifi](https://github.com/simonvic/dotfiles/wiki/Scripts#swifi) you can
quickly scan for WiFi signals, filter and connect to them with few keystrokes.

<img src="https://imgur.com/2vIHj1B.gif">

<br>

<h3 align="center">sScreenshot</h3>

[sScreenshot](https://github.com/simonvic/dotfiles/wiki/Scripts#sscreenshot)
allows you to take area or full screenshot, copy it to clipboard and paste it
anywhere.

<img src="https://imgur.com/ZfSI0Ea.gif">

<br>

<h3 align="center"> Speaker and microphone control</h3>

Nothing special here.
[sVolumectl](https://github.com/simonvic/dotfiles/wiki/Scripts#svolumectl) and
[sMicrophonectl](https://github.com/simonvic/dotfiles/wiki/Scripts#smicrophonectl)
allows you to change the volume of the speakers and microphone while showing a
dunst notification with a [personalizable
bar](https://github.com/simonvic/dotfiles/wiki/Scripts#drawbarsh)

<img src="https://imgur.com/Zz33t6s.gif" width="100%">

<br>

<h3 align="center">Brightness and Redshift control</h3>

[sBrightnessctl](https://github.com/simonvic/dotfiles/wiki/Scripts#sbrightnessctl)
will adjust the brightness and manage the "night mode" (blue shift)
temperature.

<img src="https://imgur.com/vTUWWlH.gif" width="100%">

<br>

<h3 align="center">ToDo popup with context action</h3>

[sTodo](https://github.com/simonvic/dotfiles/wiki/Scripts#stodo) is a minimal
TODO manager, which can also show a popup via the notification daemon

<p align="center">
    <img src="https://imgur.com/8OWFgx8.gif" width="50%">
    <img src="https://imgur.com/aYN9Ees.gif" width="100%">
</p>

<br>

# Contact me

<p align="center">
    <a style="margin: 0 10px" href = "mailto: simonvic.dev@gmail.com">
        <img src="https://img.shields.io/badge/Email-simonvic.dev%40gmail.com-F0544C?style=social&logo=data:image/png;base64,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&logoColor=F0544C">
    </a>
    <br>
    <a style="margin: 0 10px" href="https://matrix.to/#/@simonvic:matrix.org">
        <img src="https://img.shields.io/badge/Matrix-%40simonvic%3Amatrix%3Aorg-F0544C?logo=element&style=social">
    </a>
    <br>
    <img style="margin: 0 10px" src="https://img.shields.io/badge/Discord-simonvic-F0544C?logo=Discord&style=social">
</p>

---

<h3 align="center" >Buy me a coffee :)</h3>
<p align="center">
    <img width="40px" src="https://i.imgur.com/e3kk9J4.png">
    <a href = "https://paypal.me/simonvic">
        <img src="https://img.shields.io/badge/Paypal-donate-F0544C?style=for-the-badge&logo=paypal&logoColor=F0544C">
    </a>
</p>
