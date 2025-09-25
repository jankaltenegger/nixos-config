{
  pkgs,
  unstable-pkgs,
  inputs,
  system,
  ...
}: {
  imports = [
    ./machine/ymir/hardware-configuration.nix
  ];

  nix = {
    settings = {
      # Cachix settings for Hyprland
      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      # Regularly cleans and checks store dir
      auto-optimise-store = true;

      # Enable flakes
      experimental-features = ["nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Configuring root and main user as trusted users for cachix to let devenv manage the caching
    extraOptions = ''
      trusted-users = root jan
      warn-dirty = false
    '';

    package = pkgs.nixVersions.stable;
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  # For the love of fucking god do not touch shit below this
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
      };
    };

    initrd = {
      systemd = {
        enable = true;
        services.rollback = {
          description = "Rollback BTRFS root subvolume to a pristine state";
          wantedBy = ["initrd.target"];

          # LUKS/TPM process. If you have named your device mapper something other
          # than 'enc', then @enc will have a different name. Adjust accordingly.
          after = ["systemd-cryptsetup@niflheim.service"];

          # Before mounting the system root (/sysroot) during the early boot process
          before = ["sysroot.mount"];

          unitConfig.DefaultDependencies = "no";
          serviceConfig.Type = "oneshot";
          script = ''
            mkdir -p /mnt

            # We first mount the BTRFS root to /mnt
            # so we can manipulate btrfs subvolumes.
            mount -o subvol=/ /dev/mapper/niflheim /mnt

            # While we're tempted to just delete /root and create
            # a new snapshot from /root-blank, /root is already
            # populated at this point with a number of subvolumes,
            # which makes `btrfs subvolume delete` fail.
            # So, we remove them first.
            #
            # /root contains subvolumes:
            # - /root/var/lib/portables
            # - /root/var/lib/machines

            btrfs subvolume list -o /mnt/root |
              cut -f9 -d' ' |
              while read subvolume; do
                echo "deleting /$subvolume subvolume..."
                btrfs subvolume delete "/mnt/$subvolume"
              done &&
              echo "deleting /root subvolume..." &&
              btrfs subvolume delete /mnt/root
            echo "restoring blank /root subvolume..."
            btrfs subvolume snapshot /mnt/root-blank /mnt/root

            # Once we're done rolling back to a blank snapshot,
            # we can unmount /mnt and continue on the boot process.
            umount /mnt
          '';
        };
      };

      luks.devices."niflheim" = {
        device = "/dev/disk/by-uuid/3bc345ec-bc96-4fd2-9c19-3fab91e5f05a";
        keyFile = "/keyfile.bin";
        allowDiscards = true;
      };

      secrets = {
        "keyfile.bin" = "/etc/secrets/initrd/keyfile.bin";
      };

      kernelModules = ["amdgpu"];
    };

    extraModprobeConfig = ''
      options snd-hda-intel model=dell-headset-multi
    '';
  }; # You're good to touch shit again

  hardware = {
    enableAllFirmware = true;
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      amdvlk = {
        enable = true;
        supportExperimental.enable = true;
        support32Bit.enable = true;
      };
    };

    bluetooth = {
      enable = true;
      package = unstable-pkgs.bluez;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
  };

  services = {
    openssh.enable = true;

    xserver.videoDrivers = ["amdgpu" "modesetting"];
    fwupd.enable = true;

    printing.enable = true;
    printing.drivers = [pkgs.cups-dymo];

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "jan";
    };

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "jan";
        };
        default_session = initial_session;
      };
    };

    # Thunar Stuff
    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    hardware.bolt.enable = true;
    udev = {
      packages = [pkgs.swayosd];
    };
  };

  systemd.services = {
    swayosd-libinput-backend = {
      description = "SwayOSD LibInput backend for listening to certain keys like CapsLock, ScrollLock, VolumeUp, etc.";
      documentation = ["https://github.com/ErikReider/SwayOSD"];
      wantedBy = ["graphical.target"];
      partOf = ["graphical.target"];
      after = ["graphical.target"];

      serviceConfig = {
        Type = "dbus";
        BusName = "org.erikreider.swayosd";
        ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
        Restart = "on-failure";
      };
    };
  };

  networking = {
    hostName = "ymir";

    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    nftables.enable = true;

    firewall.allowedTCPPorts = [22 80 443];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Define a user account.
  users = {
    defaultUserShell = pkgs.zsh;
    users.jan = {
      isNormalUser = true;
      description = "Jan Kaltenegger";
      extraGroups = ["kvm" "gamemode" "wheel" "networkmanager" "docker"];
      packages = with pkgs; [brave inputs.zen-browser.packages."${system}".default];
      initialPassword = "changeme";
    };
  };

  programs = {
    zsh.enable = true;
    steam.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 20;
          desiredgov = "performance";
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          amd_performance_level = "high";
        };
      };
    };
  };

  qt.enable = true;

  environment = {
    systemPackages =
      [
        inputs.zen-browser.packages.${pkgs.system}.default
      ]
      ++ (with pkgs; [
        fwupd
        swayosd
        file
        wget
        git
        git-crypt
        gnupg
        socat
        usbutils
        libmtp
        fusee-nano
        zip
        unzip
        amdvlk
        driversi686Linux.amdvlk
        mesa
        driversi686Linux.mesa
        amdgpu_top
        htop
        faudio
        quickemu
        ssh-to-age
        git-crypt
        gvfs
      ]);

    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = 1;
    };

    persistence."/persistent" = {
      enable = true;
      directories = [ ];
      files = [
        "/etc/secrets/initrd/keyfile.bin"
      ];
      users.jan = {
        directories = [ ];
      };
    };
  };

  # Enabling and config for pipewire and wireplumber
  security = {
    rtkit.enable = true;
    pam.services.hyprlock = {};
  };

  users.extraGroups.vboxusers.members = ["jan"];

  fonts.packages = with pkgs; [
    vistafonts
    corefonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.roboto-mono
    nerd-fonts.hack
    nerd-fonts.terminess-ttf
  ];

  virtualisation.docker.enable = true;
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = pkgs.fetchurl {
      url = "https://r4.wallpaperflare.com/wallpaper/26/956/1004/fantasy-art-dragon-ultrawide-ultra-wide-hd-wallpaper-4001fb4189f6070f700851722474b2c5.jpg";
      sha256 = "15d2liwf404pp6pr1w03qmanv299aryrxcdvxp4d4l7mfjzhf0f9";
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 48;
    };
  };

  ##############################
  # DO NOT FUCKING CHANGE THIS #
  ##############################
  system.stateVersion = "24.05"; # Did you read the comment?
}
