{lib, ...}:
with lib;
{
    options.modules.threedPrinting = {
        orca-slicer = mkEnableOption {
            name = "orca-slicer";
            description = "Enable Orca Slicer";
            default = false;
        };
    };
}