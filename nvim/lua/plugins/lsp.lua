return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      lsp_zero.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },

        servers = {
          ['tsserver'] = { 'javascript', 'typescript' },
          ['lua_ls'] = { 'lua' }
        }
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})
    end
  },

  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert'
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' }
        },
        mapping = {
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ['<Up>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
          ['<Down>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' }
}
