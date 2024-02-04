{
  enable = true;
  theme = "dashboard";
  sections = {
    header = {
      type = "text";
      align = "center";
      foldSection = false;
      title = "Header";
      margin = 5;
      content.__raw = "require('startup.headers').hydra_header";
      highlight = "Statement";
      defaultColor = "";
      oldfilesAmount = 0;
    };
    body = {
      type = "mapping";
      align = "center";
      foldSection = true;
      title = "Basic Commands";
      margin = 5;
      content = [
        [
          " Find File"
          "Telescope find_files"
          "<leader>ff"
        ]
        [
          "󰍉 Find Word"
          "Telescope live_grep"
          "<leader>lg"
        ]
        [
          " Recent Files"
          "Telescope oldfiles"
          "<leader>of"
        ]
        [
          " File Browser"
          "Telescope file_browser"
          "<leader>fb"
        ]
        [
          " Colorschemes"
          "Telescope colorscheme"
          "<leader>cs"
        ]
        [
          " New File"
          "lua require'startup'.new_file()"
          "<leader>nf"
        ]
      ];
      highlight = "String";
      defaultColor = "";
      oldfilesAmount = 0;
    };
  };
}
