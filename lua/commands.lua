local command = vim.api.nvim_create_user_command

-- Create the "Settings" command
command("Settings", function()
    -- Save the current directory
    local current_dir = vim.fn.getcwd()

    -- Get the value of $XDG_CONFIG_HOME
    local xdg_config_home = os.getenv("XDG_CONFIG_HOME")

    -- If $XDG_CONFIG_HOME is not set, use the default value
    if xdg_config_home == nil then
        xdg_config_home = os.getenv("HOME") .. "/.config"
    end

    -- Construct the path to the Neovim configuration directory
    local nvim_config_dir = xdg_config_home .. "/nvim"

    -- Open a new terminal buffer
    vim.cmd("terminal")

    -- Get the current buffer number
    local buf = vim.api.nvim_get_current_buf()

    -- Send the `cd` command to the terminal buffer
    vim.api.nvim_chan_send(buf, "cd " .. nvim_config_dir .. "\n")

    -- Send the command to open the init.lua file in the terminal buffer
    vim.api.nvim_chan_send(buf, "nvim init.lua\n")

    -- Create an autocommand to restore the directory when the terminal buffer is closed
    vim.cmd("autocmd TermClose <buffer> lcd " .. current_dir)
end, {})

command("Snippets", function()
    -- open user snippets directory at $XDG_CONFIG_HOME/nvim/snippets/

end, {}
)

command("Sourcemedaddy", function()
    vim.cmd("source %")
end, {})

command("Git", "LazyGit", {})
