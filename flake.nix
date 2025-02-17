{
  description = "My neovim configuration for Nix using nvf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { nixpkgs, self, nvf }: {


  packages.x86_64-linux.default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
        (
            {pkgs, ...}: {
              config.vim = {
                # theme
                theme.enable = true;
                theme.name = "catppuccin";
                theme.style = "mocha";

                #cosmetics
                statusline.lualine.enable = true;
                ui.colorizer.enable = true;
                visuals.nvim-web-devicons.enable = true;

                telescope.enable = true;
                autocomplete.nvim-cmp.enable = true;

                #LSP
                languages = {
                  enableLSP = true;
                  enableTreesitter = true;

                  nix.enable = true;
                  ts.enable = true;
                  html.enable = true;
                  tailwind.enable = true;
                  css.enable = true;
                  sql.enable = true;
                  bash.enable = true;
                  go.enable = true;
                  lua.enable = true;
                  markdown.enable = true;
                };
              };
            }
          )
        ];
      })
      .neovim;

  };
}
