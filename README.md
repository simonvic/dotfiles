<p align="center">
    <img width="200px" src="https://i.imgur.com/TU66AEL.png">
</p>

#
<p align="center">
        <img src="https://img.shields.io/badge/version-v3.0.0-F0544C?style=for-the-badge">
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
This repository is not just a rice. In `./local/bin/` you can find many utilities (written completely in *sh*) 
which make the **everyday** usage of your Linux environment ***easier*** and ***faster***, while getting the most out of
popular softwares among Linux rices (e.g. Polybar, Rofi, Dunst, i3 etc.).

These utilities have been made to be easily configurable (*more to come in v3.0...*); just open it with your favorite text
editor and edit accordingly. For a more in-depth guide visit the [scripts wiki](https://github.com/simonvic/dotfiles/wiki/Scripts)

For a guide on how to use them either check the [wiki](https://github.com/simonvic/dotfiles/wiki/Scripts) 
or just launch them with the `help` option. Example:
```shell-session
$ sPolybarctl help
```


> Make sure to visit the [Wiki](https://github.com/simonvic/dotfiles/wiki) to have a full overview of what my workflow can offer

<br>
<br>

# Requirements
Main requirements:
* i3-gaps : the tiling window manager with gaps
* i3lock-color : Used to lock the screen
* Polybar : show bars with various information 
* Dunst : notifications daemon
* Rofi : application launcher
* more...

Visit the [installation guide](https://github.com/simonvic/dotfiles/wiki/Installation-and-Configuration) for a more in-depth explanation
 
<br>
<br>

# Showcase 
<h2 align="center"> Lockscreen (sLockscreenctl) </h1>
<img src="https://imgur.com/X4KEcVR.gif" width="100%">

[sLockscreenctl](https://github.com/simonvic/dotfiles/wiki/Scripts#slockscreenctl) has plenty of options to tweak as you like

<details>
 <summary> Other themes preview </summary>
<img src="https://imgur.com/AD6SStG.gif" width="50%">
<img src="https://imgur.com/t9re5NI.gif" width="50%">
</details>

<br>
<br>

<h2 align="center">Application launcher, window switcher and calculator (Rofi)</h2>
<img src="https://imgur.com/U2OKJvx.gif" width="100%">

[Rofi](https://github.com/simonvic/dotfiles/wiki/Installation-and-Configuration#rofi) themes have been made to be
easily configurable and expansible. The config file and thems are structured like this:
```
|_ config            (defines rofi behaviour, components and default base UI layout/structure)
|_ Theme             (defines UI layout and structure)
    |_ Style         (defines UI components color and text font)
        |_ Fonts     (defines a set of fonts)
        |_ Palette   (defines a color palette)
```
A `Theme` (e.g. fullscreen.rasi, reverse.rasi, window_reverse.rasi etc) only takes care
of how the UI components are structured and arranged. It imports a `Style`.

A `Style` defines text fonts, imported from a `Fonts`, and the colors of the components, imported from a `Palette`

<br>
<br>

<h2 align="center">Polybar</h2>
<img src="https://imgur.com/BbjNiOo.gif" width="100%">

[sPolybarctl](https://github.com/simonvic/dotfiles/wiki/Scripts#spolybarctl) will manage your polybars.
It can `launch` them, `show`, `hide` them or `toggle`. It also serves as a wrapper for polybar-msg for `ipc` calls.

The main feature is that you can interact with polybars using their name, like so:
```shell-session
$ sPolybarctl show myFirstBar                # make visible "myFirstBar"
$ sPolybarctl toggle mySecondBar             # toggle visibility state for "mySecondBar"
$ sPolybarctl hide                           # if no polybar name specified, the command will be issued to all polybars
$ sPolybarctl message "action #date.toggle"  # simulate the toggle action on date modules
```

<br>
<br>

<h2 align="center">TODO manager,Notifications and more (Dunst) </h2>

<h3 align="center"> Music control (sPlayerctl) + custom Spotify notification </h3>
<img src="https://imgur.com/0XehgiR.gif" width="100%">

[sPlayerctl](https://github.com/simonvic/dotfiles/wiki/Scripts#splayerctl) will help you manage your *music*! It also has custom Spotify notification.

The coolest feature is that you can select the player you wish to control via cli
```shell-session
$ sPlayerctl select-player set spotify
```
... or even better with `Dunst` and `Rofi`
<img src="https://i.imgur.com/ir8RoHf.png" width="100%">

<br>

<h3 align="center"> Speaker and microphone control</h3>
<img src="https://imgur.com/NAcWdqa.gif" width="100%">

Nothing special here. [sVolumectl](https://github.com/simonvic/dotfiles/wiki/Scripts#svolumectl) and [sMicrophonectl](https://github.com/simonvic/dotfiles/wiki/Scripts#smicrophonectl)
will the volume of the speakers and microphone while showing a dunst notification with a [personalizable bar](https://github.com/simonvic/dotfiles/wiki/Scripts#drawbarsh)

<br>

<h3 align="center">Brightness and Redshift control</h3>
<img src="https://imgur.com/9UBUZQg.gif" width="100%">

[sBrightnessctl](https://github.com/simonvic/dotfiles/wiki/Scripts#sbrightnessctl) will adjust the brightness and manage `redshift` temperature.

<br>

<h3 align="center">App notifications</h3>
<img src="https://imgur.com/dgIq5dr.gif" width="100%">

<br>

<h3 align="center">ToDo popup with context action</h3>
<p align="center">
    <img src="https://imgur.com/8OWFgx8.gif" width="50%">
    <img src="https://imgur.com/aYN9Ees.gif" width="100%">
</p>

[sTodo](https://github.com/simonvic/dotfiles/wiki/Scripts#stodo) is a minimal TODO list manager, which can also show a popup with dunst


# Keybindings
My workflow is 100% keyboard-driven as I have everything at the tip of my fingers.

Check out my [default keybindings](https://github.com/simonvic/dotfiles/wiki/Keybindings) for more

# About me
<p align="center">
    <img src="https://github-readme-stats.vercel.app/api?username=simonvic&hide_border=true&title_color=F0544C&icon_color=F0544C&text_color=CACACA&bg_color=DEG,333333,333333&count_private=true&show_icons=true">
    <br>
    <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=simonvic&hide_border=true&title_color=F0544C&icon_color=F0544C&text_color=CACACA&bg_color=DEG,333333,333333&layout=compact">
</p>

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
    <img style="margin: 0 10px" src="https://img.shields.io/badge/Discord-simonvic%239804-F0544C?logo=Discord&style=social">
    <br>
    <a style="margin: 0 10px" href="https://twitter.com/_simonvic_">
        <img src="https://img.shields.io/badge/Twitter-%40simonvic-F0544C?logo=twitter&style=social">
    </a>
</p>

---

<h3 align="center" >Buy me a coffee :)</h3>
<p align="center">
    <img width="40px" src="https://i.imgur.com/e3kk9J4.png">
    <a href = "https://paypal.me/simonvic">
        <img src="https://img.shields.io/badge/Paypal-donate-F0544C?style=for-the-badge&logo=paypal&logoColor=F0544C">
    </a>
</p>
