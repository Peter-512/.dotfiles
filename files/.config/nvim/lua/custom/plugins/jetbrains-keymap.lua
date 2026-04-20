-- WebStorm/JetBrains-like keybindings for Neovim
-- Uses <D-...> for Cmd key (macOS terminal must support this, e.g. Neovide, Kitty, WezTerm)
-- If your terminal doesn't pass Cmd keys, these won't fire — the <leader>-based
-- kickstart defaults will still work as a fallback.

local map = vim.keymap.set

-- Search current buffer (Cmd+F) → Telescope fuzzy find
map('n', '<D-f>', function() require('telescope.builtin').current_buffer_fuzzy_find() end, { desc = 'Search current buffer' })
map('i', '<D-f>', function() require('telescope.builtin').current_buffer_fuzzy_find() end, { desc = 'Search current buffer' })

-- Find in files (Cmd+Shift+F) → Telescope live_grep with rg args support
map('n', '<D-F>', function()
  pcall(require('telescope').load_extension, 'live_grep_args')
  require('telescope').extensions.live_grep_args.live_grep_args()
end, { desc = 'Find in files (grep)' })

-- Find file (Cmd+O) → Telescope find_files
map('n', '<D-o>', function() require('telescope.builtin').find_files() end, { desc = 'Find file' })

-- Signature help / parameter info (Cmd+P)
map({ 'n', 'i' }, '<D-p>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })

-- Recent files (Cmd+E) → Telescope oldfiles, scoped to cwd
map('n', '<D-e>', function() require('telescope.builtin').oldfiles { only_cwd = true } end, { desc = 'Recent files' })

-- Smart file tree toggle (Cmd+1)
-- Focused → close, open but unfocused → focus, closed → open and focus
map('n', '<D-1>', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == 'neo-tree' then
      if vim.api.nvim_get_current_win() == win then
        vim.cmd 'Neotree close'
      else
        vim.api.nvim_set_current_win(win)
      end
      return
    end
  end
  vim.cmd 'Neotree focus'
end, { desc = 'Toggle file tree' })

-- Go to definition (Cmd+B)
map('n', '<D-b>', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- Go to type definition (Cmd+Shift+B)
map('n', '<D-B>', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })

-- Code actions (Alt+Enter)
map({ 'n', 'i' }, '<A-CR>', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Rename symbol (Cmd+Shift+R / F2)
map('n', '<D-R>', vim.lsp.buf.rename, { desc = 'Rename symbol' })
map('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename symbol' })

-- Move line up/down (Alt+Up/Down)
map('n', '<A-Up>', '<cmd>move .-2<CR>==', { desc = 'Move line up' })
map('n', '<A-Down>', '<cmd>move .+1<CR>==', { desc = 'Move line down' })
map('i', '<A-Up>', '<Esc><cmd>move .-2<CR>==gi', { desc = 'Move line up' })
map('i', '<A-Down>', '<Esc><cmd>move .+1<CR>==gi', { desc = 'Move line down' })
map('v', '<A-Up>', ":move '<-2<CR>gv=gv", { desc = 'Move selection up' })
map('v', '<A-Down>', ":move '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- Duplicate line (Cmd+D)
map('n', '<D-d>', '<cmd>t.<CR>', { desc = 'Duplicate line' })
map('v', '<D-d>', "y'>p", { desc = 'Duplicate selection' })

-- Toggle comment (Cmd+/) and move to next line
map('n', '<D-/>', 'gccj', { remap = true, desc = 'Toggle comment' })
map('v', '<D-/>', 'gc', { remap = true, desc = 'Toggle comment' })

-- Delete line (Cmd+Shift+K)
map('n', '<D-K>', 'dd', { desc = 'Delete line' })

-- Undo / Redo (Cmd+Z / Cmd+Shift+Z)
map('n', '<D-z>', 'u', { desc = 'Undo' })
map('n', '<D-Z>', '<C-r>', { desc = 'Redo' })
map('i', '<D-z>', '<Esc>ui', { desc = 'Undo' })
map('i', '<D-Z>', '<Esc><C-r>i', { desc = 'Redo' })

-- Save + format file (Cmd+S)
map({ 'n', 'i', 'v' }, '<D-s>', function()
  require('conform').format({ async = false, lsp_format = 'fallback' }, function()
    vim.cmd 'w'
  end)
end, { desc = 'Format and save file' })

-- Close buffer/pane (Cmd+W)
map('n', '<D-w>', '<cmd>bd<CR>', { desc = 'Close buffer' })

-- Toggle git status (Cmd+0) → Neogit
map('n', '<D-0>', function() require('neogit').open() end, { desc = 'Git status' })

-- Switch buffer (Ctrl+Tab)
map('n', '<C-Tab>', function() require('telescope.builtin').buffers() end, { desc = 'Switch buffer' })

-- Command palette (Cmd+Shift+A)
map('n', '<D-A>', function() require('telescope.builtin').commands() end, { desc = 'Command palette' })

-- Toggle bottom terminal (Cmd+Shift+P)
local term_buf = nil
local term_win = nil
local function toggle_terminal()
  -- If terminal window is open, close it
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end
  -- Create or reuse terminal buffer
  if term_buf == nil or not vim.api.nvim_buf_is_valid(term_buf) then
    term_buf = vim.api.nvim_create_buf(false, true)
  end
  -- Open split at bottom, 15 rows
  vim.cmd 'botright 15split'
  term_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(term_win, term_buf)
  -- Start terminal if not already running
  if vim.bo[term_buf].buftype ~= 'terminal' then
    vim.fn.termopen(vim.o.shell, { cwd = vim.fn.getcwd() })
  end
  vim.cmd 'startinsert'
end
map({ 'n', 't' }, '<D-P>', toggle_terminal, { desc = 'Toggle terminal' })

-- Jump back/forward (Cmd+[/]) — works across files
map('n', '<D-[>', '<C-o>', { desc = 'Jump back' })
map('n', '<D-]>', '<C-i>', { desc = 'Jump forward' })

-- Select all (Cmd+A)
map('n', '<D-a>', 'ggVG', { desc = 'Select all' })

-- Word navigation (Alt+Left/Right)
map('n', '<A-Left>', 'b', { desc = 'Move word left' })
map('n', '<A-Right>', 'w', { desc = 'Move word right' })
map('i', '<A-Left>', '<C-o>b', { desc = 'Move word left' })
map('i', '<A-Right>', '<C-o>w', { desc = 'Move word right' })
map('v', '<A-Left>', 'b', { desc = 'Move word left' })
map('v', '<A-Right>', 'w', { desc = 'Move word right' })

-- Delete word backward (Alt+Backspace)
map('i', '<A-BS>', '<C-w>', { desc = 'Delete word backward' })
map('n', '<A-BS>', 'db', { desc = 'Delete word backward' })

-- Return empty table — this file sets keymaps directly, no plugins to install
return {}
