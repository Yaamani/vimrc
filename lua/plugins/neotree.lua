require("neo-tree").setup({
  filesystem = {
    bind_to_cwd = false,
    filtered_items = {
      visible = true, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false, -- only works on Windows for hidden files/directories
      hide_by_name = {
        -- ".DS_Store",
        -- "thumbs.db",
        --"node_modules",
      },
      hide_by_pattern = {
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db",
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    window = {
      mappings = {
        ["<F5>"] = "refresh",
        ["o"] = "open",
        ["oc"] = "none",
        ["od"] = "none",
        ["og"] = "none",
        ["om"] = "none",
        ["on"] = "none",
        ["os"] = "none",
        ["ot"] = "none",
        ["sc"] = "order_by_created",
        ["sd"] = "order_by_diagnostics",
        ["sg"] = "order_by_git_status",
        ["sm"] = "order_by_modified",
        ["sn"] = "order_by_name",
        ["ss"] = "order_by_size",
        ["st"] = "order_by_type",
      }
    }
  }
})
