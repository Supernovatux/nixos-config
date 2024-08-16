{ inputs, pkgs, ... }:
let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  screenshot = import ./screenshot.nix pkgs;

in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };

  };
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "~/nixos-config/home-manager/ags/wl1.webp";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          shadow_passes = 2;
        }
      ];
    };

  };
  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };
  wayland.windowManager.hyprland = {
    plugins = [
      #pkgs.hyprlandPlugins.hyprexpo
      pkgs.hyprlandPlugins.hyprspace
    ];
    enable = true;
    settings = {
      xwayland.force_zero_scaling = true;
      exec-once = [
        "ags -b hypr"
        "hyprctl setcursor Qogir 24"
	"hyprshade auto"
        "lxqt-policykit-agent"
      ];
      "$mod" = "SUPER";
      general = {
        gaps_out = 10;
        layout = "dwindle";
        resize_on_border = true;
      };
      monitor = [ "eDP-1,2560x1600@165.01900,0x0,1.6,bitdepth,10,vrr,1" ",preferred,auto,1" ];
      misc = {
        font_family = "Fira Code Nerd Font Light";
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        vrr = 1;
      };
      input = {
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = true;
          drag_lock = true;
        };
      };
      group = {
        "col.border_active" = "0x33ccffee";
        "col.border_inactive" = "0x595959aa";
        groupbar = {
          "col.active" = "0x33ccffee";
          "col.inactive" = "0x595959aa";
        };
      };
      binds = {
        allow_workspace_cycles = true;
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        # no_gaps_when_only = "yes";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_use_r = true;
      };

      bind =
        [
          "$mod, RETURN, exec, kitty -1"
          "$mod, SPACE, togglefloating"
          "$mod, f, fullscreen"
          "$mod, p, togglesplit"
          "$mod+SHIFT , q , killactive"
          "$mod, left, movefocus, l"
          "$mod, down, movefocus, d"
          " $mod, up, movefocus, u"
          "$mod,g,togglegroup"
          "$mod, right, movefocus, r"
          "$mod+CONTROL, left, movefocus, l, visible, nowarp"
          "$mod+CONTROL, down, movefocus, d, visible, nowarp"
          " $mod+CONTROL, up, movefocus, u, visible, nowarp"
          "$mod+CONTROL, right, movefocus, r, visible, nowarp"
          "$mod+SHIFT, left, movewindoworgroup, l"
          "$mod+SHIFT, down, movewindoworgroup, d"
          "$mod+SHIFT, up, movewindoworgroup, u"
          "$mod+SHIFT, right, movewindoworgroup, r"
          "$mod,tab,changegroupactive,f"
          "$mod+SHIFT,tab,changegroupactive,b"
          "$mod+CONTROL+SHIFT, left, movewindow, l, once, visible"
          "$mod+CONTROL+SHIFT, up, movewindow, u, once, visible"
          "$mod+CONTROL+SHIFT, down, movewindow, d, once, visible"
          "$mod+CONTROL+SHIFT, right, movewindow, r, once, visible"
          "$mod+SHIFT , s , exec , ${screenshot} --no-delay"
          "$mod , s , exec , ${screenshot}"

        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
      bindle = [
        ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
        ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
        ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
        ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
      ];
      bindl = [
	",switch:off:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, preferred, auto, auto\""
	",switch:on:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, disable\""
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];
      bindr = [ "SUPER,SUPER_L,exec,ags -b hypr -t launcher" ];
      decoration = {
        rounding = 10;
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 1.0e-2;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      plugin = {
        overview = {
          panelHeight = 150;
          panelBorderWidth = 20;
          gapsOut = 10;
          gapsIn = 5;
          centerAligned = true;
          hideTopLayers = true;
          hideOverlayLayers = true;
          showNewWorkspace = true;
          exitOnClick = true;
          exitOnSwitch = true;
          drawActiveWorkspace = true;
          reverseSwipe = true;
        };

        #	hyprexpo = {
        #	columns = 6;
        # gap_size = 5;
        #	enable_gesture = true;
        # gesture_fingers = 3 ; # 3 or 4
        # gesture_distance = 300; # how far is the "max"
        # gesture_positive = true; # positive = swipe down. Negative = swipe up.
        #};
      };
    };
  };
}
