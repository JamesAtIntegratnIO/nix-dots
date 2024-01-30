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
  # To use `ALT+{h,j,k,l}` to navigate windows from any mode: >vim
  {
    mode = "t";
    key = "<A-h>";
    action = "<C-\\><C-N><C-w>h";
  }
  {
    mode = "t";
    key = "<A-j>";
    action = "<C-\\><C-N><C-w>j";
  }
  {
    mode = "t";
    key = "<A-k>";
    action = "<C-\\><C-N><C-w>k";
  }
  {
    mode = "t";
    key = "<A-l>";
    action = "<C-\\><C-N><C-w>l";
  }
  {
    mode = "i";
    key = "<A-h>";
    action = "<C-\\><C-N><C-w>h";
  }
  {
    mode = "i";
    key = "<A-j>";
    action = "<C-\\><C-N><C-w>j";
  }
  {
    mode = "i";
    key = "<A-k>";
    action = "<C-\\><C-N><C-w>k";
  }
  {
    mode = "i";
    key = "<A-l>";
    action = "<C-\\><C-N><C-w>l";
  }
  {
    mode = "n";
    key = "<A-h>";
    action = "<C-w>h";
  }
  {
    mode = "n";
    key = "<A-j>";
    action = "<C-w>j";
  }
  {
    mode = "n";
    key = "<A-k>";
    action = "<C-w>k";
  }
  {
    mode = "n";
    key = "<A-l>";
    action = "<C-w>l";
  }
]
