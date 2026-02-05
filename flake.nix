{
  description = "My neovim configuration for Nix using nvf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    nixpkgs,
    self,
    nvf,
  }: {
    packages.x86_64-linux.default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          (
            {pkgs, ...}: {
              config.vim = {
                #keybinds
                globals.mapleader = " ";

                # theme
                theme = {
                  enable = true;
                  name = "catppuccin";
                  style = "mocha";
                };

                # Leet code
                utility.leetcode-nvim = {
                  enable = true;
                  setupOpts.lang = "typescript";
                };

                # Discord 🤣
                presence = {
                  neocord = {
                    enable = true;
                    setupOpts.enable_line_number = false;
                    setupOpts.show_time = false;
                  };
                };

                # Status line
                statusline = {
                  lualine.enable = true;
                  lualine.theme = "onedark"; # NOTE: dracula | gruvbox | onedark | catppuccin
                };

                ui = {
                  borders.enable = false;
                  breadcrumbs.enable = true;
                  illuminate.enable = true;

                  colorizer = {
                    enable = true;
                    setupOpts = {
                      user_default_options.tailwind = true;
                      filetypes = {
                        "*" = {
                          mode = "background";
                          tailwind = true;
                          names = true;
                          RGB = true;
                          RRGGBB = true;
                        };
                      };
                    };
                  };
                };

                # visuals
                visuals = {
                  nvim-web-devicons.enable = true;
                  indent-blankline.enable = true;
                  cellular-automaton.enable = false; # NOTE: figure out what this does.
                };

                projects.project-nvim.enable = true;
                telescope.enable = true;
                snippets.luasnip.enable = true;

                spellcheck = {
                  enable = true;
                  programmingWordlist.enable = false;
                };

                #autocomplete
                autocomplete = {
                  nvim-cmp.enable = false;
                  blink-cmp = {
                    enable = true;
                    mappings.close = "<A-Tab>";
                    friendly-snippets.enable = true;
                  };
                };

                # AI Assistant
                assistant = {
                  codecompanion-nvim = {
                    enable = true;
                    setupOpts.strategies = {
                      chat.adapter = "gemini";
                      inline.adapter = "gemini";
                    };
                  };
                  chatgpt.enable = false;
                  copilot = {
                    enable = true;
                    cmp.enable = true;
                  };
                };

                navigation.harpoon = {
                  enable = true;
                };

                autopairs.nvim-autopairs.enable = true;

                # Comments
                comments.comment-nvim = {
                  enable = true;
                  setupOpts.mappings.extra = true;
                };

                # Notes
                notes = {
                  todo-comments.enable = true; #NOTE: <leader>tds
                };

                notify = {
                  nvim-notify.enable = true;
                };

                # Terminal
                terminal = {
                  toggleterm = {
                    enable = true;
                    lazygit.enable = true;
                  };
                };

                # diagnostics
                diagnostics = {
                  enable = true;
                  config = {
                    signs = true;
                    underline = true;
                    update_in_insert = false;
                    virtual_lines = true; # virtual lines on top of the real line of code
                    virtual_text = false; # virtual_lines replaced need for this
                  };
                };

                formatter.conform-nvim = {
                  enable = true;
                  setupOpts = {
                    formatters_by_ft = {
                      javascript = ["prettier"];
                      typescript = ["prettier"];
                      javascriptreact = ["prettier"];
                      typescriptreact = ["prettier"];
                      json = ["prettier"];
                      html = ["prettier"];
                      css = ["prettier"];
                      scss = ["prettier"];
                      less = ["prettier"];
                      yaml = ["prettier"];
                      markdown = ["prettier"];
                      graphql = ["prettier"];
                      vue = ["prettier"];
                      svelte = ["prettier"];
                    };
                    format_on_save = {
                      timeout_ms = 10000;
                      lsp_fallback = "fallback"; # from reading conform github I suspect this might need to be  lsp_format = "fallback",
                    };
                  };
                };

                # LSP
                lsp = {
                  enable = true;
                  formatOnSave = false; # setting to false for now. trying to get conform.nvim to format then fallback to lsp if it can't.
                  lspsaga.enable = false;
                };

                # Languages
                languages = {
                  enableTreesitter = true;
                  enableFormat = true;
                  enableExtraDiagnostics = true;

                  nix.enable = true;
                  ts.enable = true;
                  html.enable = true;
                  tailwind.enable = true;
                  css.enable = true;
                  sql.enable = true;
                  bash.enable = true;
                  go.enable = false;
                  lua.enable = true;
                  markdown.enable = true;
                  zig.enable = false;
                  haskell.enable = true;
                  rust = {
                    enable = true;
                    extensions.crates-nvim.enable = true;
                  };
                  # temp scala and java support for FP book
                  scala.enable = true;
                  java.enable = false;
                };

                filetree.neo-tree = {
                  enable = true;
                  setupOpts = {
                    close_if_last_window = true;
                    popup_border_style = "rounded";
                  };
                };

                tabline = {
                  nvimBufferline.enable = false;
                };

                minimap = {
                  minimap-vim.enable = false;
                  codewindow.enable = false; # lighter, faster, and uses lua for configuration
                };

                # Git
                git = {
                  enable = true;
                  gitsigns.enable = true;
                  gitsigns.codeActions.enable = false; # throws an annoying debug message
                };

                # Options
                options = {
                  smartindent = true; # this one is out of place
                  autoindent = true; # Enable auto-indentation
                  backup = false; # creates a backup file
                  clipboard = "unnamedplus"; # allows neovim to access the system clipboard
                  cmdheight = 1; # more space in the neovim command line for displaying messages
                  #completeopt = { "menuone", "noselect" };
                  conceallevel = 0; # so that `` is visible in markdown files
                  fileencoding = "utf-8"; # the encoding written to a file
                  foldmethod = "manual"; # folding, set to "expr" for treesitter based folding
                  foldexpr = ""; # set to "nvim_treesitter#foldexpr()" for treesitter based folding
                  guifont = "monospace:h17"; # the font used in graphical neovim applications
                  hidden = true; # required to keep multiple buffers and open multiple buffers
                  hlsearch = true; # highlight all matches on previous search pattern
                  ignorecase = true; # ignore case in search patterns
                  mouse = "a"; # allow the mouse to be used in neovim
                  pumheight = 10; # pop up menu height
                  showmode = false; # we don't need to see things like -- INSERT -- anymore
                  smartcase = true; # smart case
                  splitbelow = true; # force all horizontal splits to go below current window
                  splitright = true; # force all vertical splits to go to the right of current window
                  swapfile = false; # creates a swapfile
                  termguicolors = true; # set term gui colors (most terminals support this)
                  timeoutlen = 1000; # time to wait for a mapped sequence to complete (in milliseconds)
                  title = true; # set the title of window to the value of the titlestring
                  undofile = true; # enable persistent undo
                  updatetime = 100; # faster completion
                  writebackup = false; # if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
                  expandtab = true; # convert tabs to spaces
                  shiftwidth = 2; # the number of spaces inserted for each indentation
                  tabstop = 2; # insert 2 spaces for a tab
                  cursorline = true; # highlight the current line
                  number = true; # set numbered lines
                  numberwidth = 4; # set number column width to 2 {default 4}
                  signcolumn = "yes"; # always show the sign column, otherwise it would shift the text each time
                  wrap = false; # display lines as one long line
                  scrolloff = 8; # minimal number of screen lines to keep above and below the cursor.
                  sidescrolloff = 8; # minimal number of screen lines to keep left and right of the cursor.
                  showcmd = false;
                  ruler = false;
                  relativenumber = true;
                  laststatus = 3;
                };

                keymaps = [
                  # My custom hotkeys 🧶
                  {
                    # Save
                    key = "<C-s>";
                    mode = "n";
                    silent = false;
                    action = ":w<CR>";
                  }
                  {
                    # Move one right
                    key = "<C-l>";
                    mode = "i";
                    silent = false;
                    action = "<Right>";
                  }
                  {
                    # add empty line without insert mode
                    key = "<M-o>";
                    mode = "n";
                    silent = false;
                    action = ":normal! o<CR>";
                  }
                  {
                    # Insert a new line above the current line and return to "normal" mode
                    key = "<M-O>";
                    mode = "n";
                    silent = false;
                    action = ":normal! O<CR>";
                  }
                  {
                    # Toggle between absolute and relative line numbers with <Leader>n
                    key = "<leader>n";
                    mode = "n";
                    silent = false;
                    action = ":set relativenumber!<CR>";
                  }
                  {
                    # LSP info
                    key = "<Leader>lsp";
                    mode = "n";
                    silent = false;
                    action = ":LspInfo<CR>";
                  }
                  {
                    # rename fuctions
                    key = "<leader>rn";
                    mode = "n";
                    silent = false;
                    action = "<cmd>lua vim.lsp.buf.rename()<CR>";
                  }
                  {
                    # show error in float
                    key = "<leader>d";
                    mode = "n";
                    silent = false;
                    action = "<cmd>lua vim.diagnostic.open_float()<cr>";
                  }
                  {
                    # Reset file back to last save
                    key = "<leader>E";
                    mode = "n";
                    silent = false;
                    action = ":e!<cr>";
                  }

                  # from primogen. 👾
                  {
                    # move highlighted
                    key = "<M-j>";
                    mode = "n";
                    silent = false;
                    action = ":m '>+1<CR>gv=gv";
                  }
                  {
                    # move highlighted 2
                    key = "<M-k>";
                    mode = "n";
                    silent = false;
                    action = ":m '<-2<CR>gv=gv";
                  }
                  {
                    # J stay in place. # tbh idk what this one does.
                    key = "J";
                    mode = "n";
                    silent = false;
                    action = "mzJ`z";
                  }
                  {
                    # move half page
                    key = "<C-d>";
                    mode = "n";
                    silent = false;
                    action = "<C-d>zz";
                  }
                  {
                    # move half page 2
                    key = "<C-u>";
                    mode = "n";
                    silent = false;
                    action = "<C-u>zz";
                  }
                  {
                    # search
                    key = "n";
                    mode = "n";
                    silent = false;
                    action = "nzzzv";
                  }
                  {
                    # search 2
                    key = "N";
                    mode = "n";
                    silent = false;
                    action = "Nzzzv";
                  }
                  {
                    # no more capital Q
                    key = "Q";
                    mode = "n";
                    silent = false;
                    action = "<nop>";
                  }
                  {
                    # replace highlighted word
                    key = "<leader>s";
                    mode = "n";
                    silent = false;
                    action = ":%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>";
                  }
                  # keymaps for plugins
                  {
                    # neotree
                    key = "<leader>e";
                    mode = "n";
                    silent = true;
                    action = ":Neotree left<CR>";
                  }
                  {
                    # undotree
                    key = "<F5>";
                    mode = "n";
                    silent = true;
                    action = ":UndotreeToggle<CR>";
                  }
                ];
                extraPlugins = with pkgs.vimPlugins; {
                  undotree = {
                    package = undotree;
                  };
                };
              };
            }
          )
        ];
      })
      .neovim;
  };
}
