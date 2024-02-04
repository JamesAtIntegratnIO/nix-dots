{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.editor;
in {
  config = mkIf cfg.neovim {
    programs.nixvim.keymaps = [
      # NvimTree
      {
        key = "<leader>ft";
        action = "<cmd>NvimTreeToggle<CR>";
      }
      # Telescope
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        key = "<leader>fp";
        action = "<cmd>Telescope git_files<CR>";
      }
      {
        key = "<leader>of";
        action = "<cmd>Telescope oldfiles<CR>";
      }
      # Map escape for terminal :tnoremap <Esc> <C-\><C-n>
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
      }
      # Barbar
      {
        key = "<A-,";
        action = "<cmd>BufferPrevious<CR>";
      }
      {
        key = "<A-.";
        action = "<cmd>BufferNext<CR>";
      }
      {
        key = "<A-1>";
        action = "<cmd>BufferGoto 1<CR>";
      }
      {
        key = "<A-2>";
        action = "<cmd>BufferGoto 2<CR>";
      }
      {
        key = "<A-3>";
        action = "<cmd>BufferGoto 3<CR>";
      }
      {
        key = "<A-4>";
        action = "<cmd>BufferGoto 4<CR>";
      }
      {
        key = "<A-5>";
        action = "<cmd>BufferGoto 5<CR>";
      }
      {
        key = "<A-6>";
        action = "<cmd>BufferGoto 6<CR>";
      }
      {
        key = "<A-7>";
        action = "<cmd>BufferGoto 7<CR>";
      }
      {
        key = "<A-8>";
        action = "<cmd>BufferGoto 8<CR>";
      }
      {
        key = "<A-9>";
        action = "<cmd>BufferGoto 9<CR>";
      }
      {
        key = "<A-0>";
        action = "<cmd>BufferLast<CR>";
      }
      {
        key = "<A-c>";
        action = "<cmd>BufferClose<CR>";
      }
      {
        key = "<A-w>";
        action = "<cmd>BufferWipeout<CR>";
      }
      {
        key = "<C-p>";
        action = "<cmd>BufferPick<CR>";
      }
      {
        key = "<b-b>";
        action = "<cmd>BufferOrderByBufferNumber<CR>";
      }
      {
        key = "<b-d>";
        action = "<cmd>BufferOrderByDirectory<CR>";
      }
      {
        key = "<b-l>";
        action = "<cmd>BufferOrderByLanguage<CR>";
      }
      {
        key = "<b-w>";
        action = "<cmd>BufferOrderByWindowNumber<CR>";
      }
      {
        key = "<A-p>";
        action = "<cmd>BufferPin<CR>";
      }
      {
        key = "<A-x>";
        action = "<cmd>BufferCloseBuffersLeft<CR>";
      }
      {
        key = "<A-c>";
        action = "<cmd>BufferCloseBuffersRight<CR>";
      }
    ];
  };
}
