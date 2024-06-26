# Mulletware Neovim Configuration
You can install [Neovim](https://neovim.io/) and clone this repo directly to ${XDG_CONFIG_HOME:-$HOME/.config}/nvim to get started:

```sh
git clone https://github.com/mulletware/nvim-boilerplate --depth=1 ${XDG_CONFIG_HOME:-$HOME/.config}/.config/nvim
```

For a more complete experience, use [Neovide](https://neovide.dev/) as your terminal emulator.

## Installation

### For Normal Users

```sh
git clone https://github.com/mulletware/nvim-boilerplate --depth=1 ~/.config/nvim

cd ~/.config/nvim
git remote remove origin
git remote add origin https://github.com/[your-username]/nvim-config ```

### For Contributors or Forkers who want future updates

```sh
git clone https://github.com/mulletware/nvim-boilerplate ~/${XDG_CONFIG_HOME:-$HOME/.config}/nvim
cd ~/${XDG_CONFIG_HOME:-$HOME/.config}/nvim
git remote add upstream $(git remote get-url origin) # transfer origin to upstream for boilerplate updates (only needed for boilerplate contributions)
git remote remove origin
git remote add origin https://github.com/[your-username]/nvim-config # your new git project
git push --set-upstream origin main # set upstream branch to track boilerplate
git checkout -b upstream
git config push.default upstream upstream:main
git checkout main
```

Now clone your snippets repo inside your neovim config project at ~/.config/nvim/snippets

```sh
  cd ~/${XDG_CONFIG_HOME:-$HOME/.config}/nvim
  git clone https://github.com/[your-username]/snippets.git
```

The snippets can be in [Snipmate](https://github.com/garbas/vim-snipmate) or VSCode format.

## Dependencies

- [Neovim](https://neovim.io/) 0.9.0+
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- [Rip](https://github.com/nivekuil/rip)
- [fzf](https://github.com/junegunn/fzf)
- [sad](https://github.com/ms-jpq/sad)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- [LSP](https://microsoft.github.io/language-server-protocol) Servers
  - See the 'servers' section of lua/lsp.lua
  - Consult [LSP Server Configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) for each language you want to support
  - You may already have some installed or you may need to install all of them manually
  - For the preconfigured languages in this project, you will need:
    - Golang
    - Python
    - Rust
    - C/C++
    - PHP/Composer
- Making Requests
  - [rest.nvim](https://github.com/rest-nvim/rest.nvim) (already installed)
    - python
    - curl
    - jq
    - tidy

If you want to make changes to this configuration, it is best to fork this project under your own github account, then follow Mulletware's process for [ Managing Forked Projects ]( https://wiki.mulletware.io/en/code/vcs/upstreams/forked ) for incorporating any future updates to the boilerplate into your own version of the config project.

The important files you may want to edit are located at:

- ./lua/plugins/init.lua <-- most plugins are listed here, some are in ./init.lua
- ./lua/keymaps.lua
- ./lua/commands.lua
- ./snippets/*.lua -- [language].lua, using [Snipmate](https://github.com/msanders/snipmate.vim) (:h luasnip-lsp-snippets-snipmate-parser)
  - these can be cloned from your own git repo
- ./lua/user/*.lua

## Commands

- :DeleteCurrentFile (tries to use safe `rip`, falls back to unsafe `rm`)
- :Rename {newRelativePathFileName}
- :FormattingDisable
- :FormattingEnable
- :FormattingToggle
- :CopyFilePath
- :CopyRelativePath
- :[Request](https://github.com/rest-nvim/rest.nvim)
- :DBUI Connects to databases
- :Spectre for multi-file search/replace with visual feedback
- Git plugins
  - :Neogit
  - :LazyGit
  - :Git (Vim Fugitive)
  - :Gitsigns

Hotkeys:

- Toggle File Tree: `Ctrl+b`
- Fuzzy find file: `Ctrl+p`
- Run Vim command: `:, ;, Ctrl+Shift+p`
- Run terminal command: `!`
- Run terminal command, output to buffer: `Ctrl+1`
- Indent/Unindent: `Ctrl+], Ctrl+[`
- Open directory by path: `~`
- Comment lines: `Ctrl+/`
- Comment block: `gc[pattern]`
- Git diff: `<Space>gd`
- Go To Deifnition: `gd`
- LazyGit: `<Space>lg`
- Neogit: `<Space>gg`
- Toggle Minimap: `Ctrl+m`
- Rename all occurrences: `<Space>rw`
- Move lines up/down: `Ctrl+Shift+k/j`
- Multi-cursor select: `Ctrl+n for first instance, Ctrl+n or just n for others` (Ctrl+d would be preferred if not already a Vim command)
- Multi-cursor skip: `q` when in multi-cursor mode
- Cursor per line (visual mode): `Ctrl+Shift+L`
- Navigate to tabs 1-9: `<Space>1-9`
- Add Harpoon Mark: `<Space>ha`
- Open Harpoon: `<Space>h`
- Navigate to Harpoon marked tabs: `<Space>h1-9`
- Window Panes:
  - Focus Left: <Ctrl+h>
  - Focus Right: <Ctrl+l>
  - Focus Down: <Ctrl+j>
  - Focus Up: <Ctrl+k>
  - Open Right <Ctrl+Alt+h>
  - Open New Right: <Ctrl+Alt+l>
  - Open Down: <Ctrl+Alt+k>
  - Open New Down: <Ctrl+Alt+j>
  - Close: <Ctrl+Alt+w>
  - Destroy Others: <Ctrl+Alt+o>
  - Resize Down horizontally: <Ctrl+Shift+Alt-h>
  - Resize Up horizontally: <Ctrl+Shift+Alt-l>
  - Resize Down vertically: <Ctrl+Shift+Alt-j>
  - Resize Up horizontally: <Ctrl+Shift+Alt-k>


## Things you'll want to read about

- [Vim Fugitive](https://github.com/tpope/vim-fugitive)
- [Lazy Git](https://github.com/kdheepak/lazygit.nvim)
- [Vim Visual Multi](https://github.com/mg979/vim-visual-multi)
- [Harpoon](https://github.com/ThePrimeagen/harpoon)
- Help Entries (:h [topic])
- [Neovim Docs](https://neovim.io/doc)
- [Neovide](https://neovide.dev/)
- [LSP Server Configuration](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

Run `:checkhealth` for more information about what your system needs

# kickstart.nvim (Original Readme.md)

## Introduction

A starting point for Neovim that is:

- Small
- Single-file
- Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

> **NOTE**
> [Backup](#FAQ) your previous configuration (if any exists)

External Requirements:

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If want to write Typescript, you need `npm`
  - If want to write Golang, you will need `go`
  - etc.

> **NOTE**
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%userprofile%\AppData\Local\nvim\` |
| Windows (powershell)| `$env:USERPROFILE\AppData\Local\nvim\` |

### Install Kickstart

Clone kickstart.nvim:

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git %userprofile%\AppData\Local\nvim\
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git $env:USERPROFILE\AppData\Local\nvim\
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status.

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim.

### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### Recommended Steps

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
(so that you have your own copy that you can modify) and then install. You
can install it on your machine using the methods above.

> **NOTE**
> Your fork's url will be something like this: `https://github.com/<your_github_username>/kickstart.nvim.git`

#### Examples of adding popularly requested plugins

NOTE: You'll need to uncomment the line in the init.lua that turns on loading custom plugins.

<details>
  <summary>Adding autopairs</summary>

This will automatically install [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) and enable it on startup. For more information, see documentation for [lazy.nvim](https://github.com/folke/lazy.nvim).

In the file: `lua/custom/plugins/autopairs.lua`, add:

```lua
-- File: lua/custom/plugins/autopairs.lua

return {
  "windwp/nvim-autopairs",
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require("nvim-autopairs").setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
```

</details>
<details>
  <summary>Adding a file tree plugin</summary>

This will install the tree plugin and add the command `:Neotree` for you. For more information, see the documentation at [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim).

In the file: `lua/custom/plugins/filetree.lua`, add:

```lua
-- File: lua/custom/plugins/filetree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {}
  end,
}
```

</details>

### FAQ

* What should I do if I already have a pre-existing neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the neovim files in `~/.local` which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME` to maintain multiple configurations. For example, you can install the kickstart configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative config directory and the matching local directory `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#Install-Kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git
echo "deb https://deb.debian.org/debian unstable main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install -t unstable neovim
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find neovim
```
</details>

