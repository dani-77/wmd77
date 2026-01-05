# wmd77

This is my Penrose based X11 Tiling Window Manager.

![wmd77](wmd77_desk.png?raw=true)

Since the first release, I've added a few things, namely:

- Monocle, Grid, Fibonacci and Tatami layouts;

- Window rules for some programs;

- A scratchpad;

- A more complete status bar script;

- A session menu to logout, reboot and shutdown (requires dmenu).

## WIP

A status bar implementation that won't need the script to return info; about that I am not 
so sure because Penrose_ui lib only has Volume, Date & Time, Wifi and Battery states. 

## Build Dependencies

- cargo & rust

- libX11-devel, libXft-devel

- make

## Running Dependencies

- dbus

- dmenu

- st 

### Optional dependencies

- dunst

- feh

- redshift

- scrot

- slock

- sxhkd

- udiskie

- xautolock

- xcompmgr

# Build / Install

To build and use locally:

```
$ make
```

And then run the package:

```
$ target/release/./wmd77
```

To install:

```
$ sudo make install
```

## Keybinds

Eventhough you can swap any of it, by default:

super + return -> st (suckless terminal)

super + d -> dmenu (suckless menu)

super + shift + f -> full screen toggle

super + j/k -> swap focused window

super + shift + j/k -> swap position focused window

super + m -> change layout

super + q -> kill focused window

super + s -> scratchpad toggle

super + x -> session menu

super + shift + q -> quit WM

# Credits

- Huge thanks to [sminez](https://github.com/sminez) for the fantastic Penrose Library, examples and HowTo videos in Youtube.


Happy hacking!

