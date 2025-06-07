return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
    'ravitemer/mcphub.nvim',
  },
  config = function(_, opts)
    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'openrouter_gemini',
          keymaps = {
            close = {
              modes = { n = '<leader>ccw', i = '<C-c><C-w>' },
            },
          },
          tools = {
            ['mcp'] = {
              callback = require 'mcphub.extensions.codecompanion',
              description = 'Call tools and resources from the MCP Servers',
              opts = {
                requires_approval = true,
              },
            },
          },
          show_settings = false,
        },
        slash_commands = {
          ['file'] = {
            callback = 'strategies.chat.slash_commands.file',
            description = 'Select a file using telescope',
            opts = {
              provider = 'telescope',
            },
          },
        },
        inline = {
          adapter = 'openrouter_gemini',
        },
        cmd = {
          adapter = 'openrouter_gemini',
        },
      },
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            schema = {
              model = {
                default = 'o3-mini',
              },
            },
            env = {
              OPENAI_API_KEY = vim.fn.getenv 'OPENAI_API_KEY',
            },
          })
        end,
        githubmodels = function()
          return require('codecompanion.adapters').extend('githubmodels', {
            schema = {
              model = {
                default = 'DeepSeek-R1',
              },
            },
          })
        end,
        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            env = {
              api_key = vim.fn.getenv 'GEMINI_API_KEY',
            },
            schema = {
              model = {
                default = 'gemini-2.5-pro-exp-03-25',
              },
            },
          })
        end,
        openrouter_gemini = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              url = 'https://openrouter.ai/api',
              api_key = vim.fn.getenv 'OPENROUTER_API_KEY',
              chat_url = '/v1/chat/completions',
            },
            schema = {
              model = {
                default = 'google/gemini-2.5-pro-exp-03-25:free',
              },
            },
          })
        end,
      },
    }
    -- add 2 commands:
    --    CodeCompanionSave [space delimited args]
    --    CodeCompanionLoad
    -- Save will save current chat in a md file named 'space-delimited-args.md'
    -- Load will use a telescope filepicker to open a previously saved chat

    -- create a folder to store our chats
    local Path = require 'plenary.path'
    local data_path = vim.fn.stdpath 'data'
    local save_folder = Path:new(data_path, 'cc_saves')
    if not save_folder:exists() then
      save_folder:mkdir { parents = true }
    end

    -- telescope picker for our saved chats
    vim.api.nvim_create_user_command('CodeCompanionLoad', function()
      local t_builtin = require 'telescope.builtin'
      local t_actions = require 'telescope.actions'
      local t_action_state = require 'telescope.actions.state'

      local function start_picker()
        t_builtin.find_files {
          prompt_title = 'Saved CodeCompanion Chats | <c-d>: delete',
          cwd = save_folder:absolute(),
          attach_mappings = function(_, map)
            map('i', '<c-d>', function(prompt_bufnr)
              local selection = t_action_state.get_selected_entry()
              local filepath = selection.path or selection.filename
              os.remove(filepath)
              t_actions.close(prompt_bufnr)
              start_picker()
            end)
            return true
          end,
        }
      end
      start_picker()
    end, {})

    -- save current chat, `CodeCompanionSave foo bar baz` will save as 'foo-bar-baz.md'
    vim.api.nvim_create_user_command('CodeCompanionSave', function(opts)
      local codecompanion = require 'codecompanion'
      local success, chat = pcall(function()
        return codecompanion.buf_get_chat(0)
      end)
      if not success or chat == nil then
        vim.notify('CodeCompanionSave should only be called from CodeCompanion chat buffers', vim.log.levels.ERROR)
        return
      end
      if #opts.fargs == 0 then
        vim.notify('CodeCompanionSave requires at least 1 arg to make a file name', vim.log.levels.ERROR)
      end
      local save_name = table.concat(opts.fargs, '-') .. '.md'
      local save_path = Path:new(save_folder, save_name)
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      save_path:write(table.concat(lines, '\n'), 'w')
    end, { nargs = '*' })
  end,
}
