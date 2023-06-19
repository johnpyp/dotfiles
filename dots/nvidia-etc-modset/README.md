# nvidia-drm.modeset param

This script isn't necessary sometimes... check how to check first

# Why?

https://github.com/phillipberndt/autorandr#udev-triggers-with-nvidia-cards

to quote:

```
In order for udev to detect drm events from the native NVidia driver, the kernel parameter nvidia-drm.modeset must be set to 1. For example, add a file /etc/modprobe.d/nvidia-drm-modeset.conf:

options nvidia_drm modeset=1
```

If we don't have this, the computer can't detect that we switched monitors, I guess.

# How to check?

To check if the `nvidia-drm.modeset` parameter is set, you can use the following command in a terminal window:

```
cat /sys/module/nvidia_drm/parameters/modeset
```

If the output is `Y` or `1`, then the parameter is set. If the output is `N` or `0`, then the parameter is not set.

Alternatively, you can also check the kernel command line options by running the following command:

```
cat /proc/cmdline
```

If the `nvidia-drm.modeset` parameter is set, you will see it listed in the output.

Note: The `nvidia-drm.modeset` parameter is used to enable or disable the kernel mode setting (KMS) feature for the NVIDIA driver. If KMS is enabled, it allows the kernel to set the display resolution and other display-related parameters during boot, instead of relying on the X server to do so. This can improve performance and stability in some cases.
