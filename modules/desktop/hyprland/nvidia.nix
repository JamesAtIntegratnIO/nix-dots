{ lib, config, inputs, pkgs, ... }: with lib; let 
    username = import ../../../username.nix;
    cfg = config.modules.desktop;
    inherit (config.modules) graphics;
in {
    config = mkMerge [
        (mkIf ((cfg.desktop == "hyprland") && (graphics.type == "nvidia")){
            home-manager.users.${username} = {
                wayland.windowManager.hyprland.settings = {
                    env = [
                        "LIBVA_DRIVER_NAME,nvidia"
                        "XDG_SESSION_TYPE,wayland"
                        "GBM_BACKEND,nvidia-drm"
                        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
                        "WLR_NO_HARDWARE_CURSORS,1"
                    ];
                };
                
            };
            xdg.portal = {
                    # extraPOrtals = with pkgs; [
                    #     xdg-desktop-portal-wlr
                    # ];
                    enable = true;
                    wlr.enable = true;
                };
        })
    ];
    
}