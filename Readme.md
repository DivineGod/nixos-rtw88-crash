# rtw88 crash with rtl8822ce pci card on NanoPC-T6 LTS

During development for [Dogebox](https://dogebox.org/) I have found an issue
with the rtw88 wifi driver when scanning for available networks as root with
the wifi module in AP + STA mode.

Contained in this repo are my debugging notes and any scripts and minimal repro
cases.

## Minimal Reproduction NixOS configuration

In the `pocOS` folder I have configured a flake that can be used to build an 
SD card that's can be booted on the NanoPC-T6.

Once booted there is an open ssh port for the `poc` with no password needed.

### Build on macOS

I run nix builds in [`orbstack`](https://orbstack.dev/)

```bash
cd pocOS/
orb run nix develop
nix build .#image
```

To enter the nix environment and build the image.

The resulting `img` is located in the `result` folder and it needs to be copied
as the symlink doesn't exist outside the orb container

```bash
sudo cp -f result/sd-image/nixos-image-sd-card-25.11.20251215.c8cfcd6-aarch64-linux.img ./pocos.img
```

The specific name will certainly not be exactly the same as the above.


### Copy Image to SD Card

We need to copy the resulting image to an SD Card!

I use Balena Etcher, but `dd` works great too.

## Triggering the crash

With a monitor and keyboard attached to the NanoPC-T6.

 * Insert the SD Card.
 * Power on the device.

When the device has booted there should be a new wireless network available.

Use a separate device that you can use ssh from to connect to the wifi from the device.
Alternatively you can add an Ethernet cable to Eth1 and use the IP or the mDNS hostname.

```bash
ssh poc@pocos.local
```

In the SSH Session you can run `journalctl -f` or `dmesg --follow` to get the log output.

On the nanopc-t6 box run `iwlist wlP3p49s0 scan` and note that the command completes succesfully.

Next run the same command with `sudo`:

```bash
sudo iwlist wlP3p49s0 scan
```

The console will not show any output and any keyboard input or power button on the box won't work either.

The SSH session will still be working and you can look at the log output.

## Logs and Analysis Documentation

I've compiled logs and analysis documentation in the `analysis` folder
