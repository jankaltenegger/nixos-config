{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on eDP-1";
      };

      listener = [
        {
          timeout = "3000";
          on-timeout = "loginctl lock-session";
          on-resume = "notify-send \"Welcome back\"";
        }
        {
          timeout = "3300";
          on-timeout = "hyprctl dispatch dpms off eDP-1";
          on-resume = "hyprctl dispatch dpms on eDP-1";
        }
        {
          timeout = "6000";
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
