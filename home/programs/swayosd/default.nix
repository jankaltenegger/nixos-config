{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."swayosd/style.css".text = ''
    window {
        border-radius: 24px;
        border: none;
        background:alpha( #2E3440, 0.8);
    }

    #container {
        margin: 24px 40px;
        min-width: 194px;
    }

    image, label {
        color: #E5E9F0;
    }

    progressbar:disabled,
    image:disabled {
        opacity: 0.5;
    }

    progressbar {
        min-height: 6px;
        border-radius: 999px;
        background: transparent;
        border: none;
    }

    trough {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: alpha(#E5E9F0, 0.5);
    }

    progress {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: #E5E9F0;
    }
  '';
  services.swayosd = {
    enable = true;
    topMargin = 0.92;
    stylePath = "${config.xdg.configHome}/swayosd/style.css";
  };
}
