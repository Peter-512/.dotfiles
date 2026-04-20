return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
    keys = {
      { '<leader>gg', function() require('neogit').open() end, desc = '[G]it Neo[g]it' },
      { '<leader>gc', function() require('neogit').open { 'commit' } end, desc = '[G]it [C]ommit' },
      { '<leader>gp', function() require('neogit').open { 'push' } end, desc = '[G]it [P]ush' },
    },
  },
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = '[G]it [D]iffview' },
      { '<leader>gl', '<cmd>DiffviewFileHistory<CR>', desc = '[G]it [L]og (file history)' },
      { '<leader>gf', '<cmd>DiffviewFileHistory %<CR>', desc = '[G]it current [F]ile history' },
    },
    opts = {},
  },
}
