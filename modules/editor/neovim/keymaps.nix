[
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
  # Map escape for terminal :tnoremap <Esc> <C-\><C-n>
  {
    mode = "t";
    key = "<Esc>";
    action = "<C-\\><C-n>";
  }
]
