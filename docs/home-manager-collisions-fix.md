# Home Manager Collision Fixes

## Problem
The hm-activate service was failing due to collisions between system-level and home-manager service definitions.

## Identified Collisions

### 1. SwayOSD Triple Collision
Three separate instances of swayosd were trying to start:

1. **System-level service**: `systemd.services.swayosd-libinput-backend` in `system/configuration.nix`
2. **Home-manager service**: `services.swayosd.enable = true` in `home/programs/swayosd/default.nix`
3. **Manual exec-once**: `"sleep 5; swayosd-server"` in `home/programs/hyprland/default.nix`

### 2. Hyprland Package Mismatch
The greetd service was using a different Hyprland package source than the rest of the system:

- **Greetd**: Used `${pkgs.hyprland}/bin/Hyprland` (from nixpkgs)
- **System programs**: Used `inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland` (from flake input)
- **Home-manager**: Set to `package = null` to defer to system configuration

## Solutions Implemented

### SwayOSD Fix
**Removed** the manual `exec-once` entry for `swayosd-server` from `home/programs/hyprland/default.nix`.

**Rationale**: 
- The home-manager service (`services.swayosd.enable = true`) already handles starting the swayosd server
- The system-level `swayosd-libinput-backend` service is still needed for hardware key event handling
- Manual exec-once was redundant and causing conflicts

### Hyprland Package Fix
**Updated** greetd configuration in `system/configuration.nix` to use the same Hyprland package from flake inputs:

```nix
command = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/Hyprland";
```

**Rationale**:
- Ensures consistency across the entire system
- Avoids version mismatches between greetd and the configured Hyprland
- Aligns with the `programs.hyprland` configuration

## Current Architecture

### System Level (`system/configuration.nix`)
- `programs.hyprland.enable = true` - Sets up Hyprland with the flake input package
- `systemd.services.swayosd-libinput-backend` - Handles hardware key events system-wide
- `services.udev.packages = [pkgs.swayosd]` - Adds udev rules for swayosd
- `environment.systemPackages` includes swayosd - Makes binary available
- `services.greetd` - Launches Hyprland session using the same package

### Home Manager Level (`home/programs/`)
- `wayland.windowManager.hyprland.enable = true` with `package = null` - Configures Hyprland without managing the package
- `services.swayosd.enable = true` - Manages the user-level swayosd server
- `services.hypridle.enable = true` - Manages idle daemon
- Other user-specific services (kanshi, mpd, swaync)

## Best Practices

1. **Service Ownership**: System-level services should handle hardware/system-wide concerns, home-manager should handle user-specific services
2. **Package Consistency**: When using flake inputs, ensure all references use the same package source
3. **Avoid Manual Service Management**: Let home-manager or systemd handle service lifecycle instead of manual exec-once commands
4. **Package Deduplication**: Set `package = null` in home-manager when the package is managed at the system level

## Testing
After these changes, the configuration should build successfully without home-manager collisions. The hm-activate service should start properly.

To verify:
```bash
sudo nixos-rebuild switch --flake /path/to/nixos-config/
systemctl --user status swayosd
systemctl status swayosd-libinput-backend
```
