# wmd77

This is my Penrose based X11 Tiling Window Manager.

![wmd77](wmd77_desk.png?raw=true)

## Dependencies

- cargo & rust

- libX11-devel, libXft-devel

- make

### Optional dependencies

- dmenu

- feh

- redshift

- scrot

- slock

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

super + return -> st (terminal)

super + a -> rofi

super + d -> dmenu

super + j/k -> swap focused window

super + m -> change layout

super + p -> scrot

super + q -> kill focused window

super + r -> gmrun

super + s -> scratchpad

super + t -> lock

super + x -> powermenu

super + shift + q -> quit WM

# Credits

- Huge thanks to [sminez](https://github.com/sminez) for the fantastic Penrose Library, examples and HowTo videos in Youtube.


Happy hacking!

