# Links

RTW88 Issue: [#418: RTL8822CE crash running iwlist <device> scan in AP+STA mode ](https://github.com/lwfinger/rtw88/issues/418)
Dogebox: [dogebox.org](https://dogebox.org)
My blog post: [Debugging a linux kernel driver](https://blog.mjolner.tech/blog/debugging-rtw88)

# Timeline

 - 2025-11-27 — Added `create_ap` service to NixOS.
 - 2025-12-01 — Added back-ported rtw88 driver added to the kernel modules.
 - 2025-12-01 — Noticed crash when scanning for wifi networks.
 - 2025-12-02 to 2025-12-12 — Side tracked working on mainline kernel on nanopc-t6
 - 2025-12-15 — Got the wifi AP branch working with my mainline kernel branch.
 - 2025-12-16 — Discovered the issue was only triggered with root priveleges, filed bug.
 - 2025-12-17 — Bug was fixed overnight. I added a custom kernel module to the wifi branch on old kernel.
