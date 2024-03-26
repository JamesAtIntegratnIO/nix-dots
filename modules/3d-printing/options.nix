{lib, ...}:
with lib;
{
    options.modules.3dPrinting = {
        orca-slicer = mkEnableOption {
            name = "orca-slicer";
            description = "Enable Orca Slicer";
            default = false;
        };
    }
}