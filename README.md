# simonvic personal full-keyboard driven rice/workflow 
WIP... Editing...

## Getting started
Make sure to visit the [Wiki](https://github.com/simonvic/dotfiles/wiki) to have a ful overview of what my workflow can offer

## Requirements
Main requirements:
* i3-gaps : the tiling window manager with gaps
* i3lock : Used to lock the screen
* Polybar : show bars with various information 
* Dunst : notifications daemon
* Rofi : application launcher

Visit the [installation guide](https://github.com/simonvic/dotfiles/wiki/Installation) for a more in-depth explanation

## Keybindings
[Check the wiki](https://github.com/simonvic/dotfiles/wiki/Keybindings)
 
## Lockscreen (i3lock)
![circleblur](Preview/lockscreen_circle_blur.gif)

<details>
 <summary> Other themes preview </summary>
 
![barblur](Preview/lockscreen_bars_blur.gif)
![image](Preview/lockscreen_image.gif)

</details>

## Application launcher (Rofi)
![Rofi](Preview/rofi.gif)

## Polybar with auto-hide wrapper
![polybar](Preview/polybar_background.gif)

## Notifications and more (Dunst)
### Playerctl control + custom Spotify notification
![playerctl](https://imgur.com/CXvSvrk.gif)
### Speaker and microphone control
![volume](https://imgur.com/qwqZkWd.gif)
### Brightness and Redshift control
![screen](https://imgur.com/5nRhvXl.gif)
### App notifications
![notifications](https://imgur.com/Xpre5zb.gif)

* Modules in main polybar: 
  * i3
  * l.date / extended date
  * net information (WiFI/Eth with down/up speed)
  * Redshift switch and temperature regolation
  * Brigthness
  * Volume
  * Battery
* Module in secondary polybar: 
  * window title
  * Net information (WiFi/eth with SSID/localIP and down/up speed)
  * Redshift switch and temperature regolation with temperature in K
  * Brightness bar
  * Volume bar 
  * Brightness bar
  * Battery 
  * Powermenu
     * Reboot
     * Shutdown
     * Sleep
* Module in tertiary polybar: 
  * Keyboard (layout, caps lock, num locks etc)
  * AUR packages update
  * Disk space
  * RAM
  * CPU
  * Fan speed
  * Temperature
  * Sliding todo list
