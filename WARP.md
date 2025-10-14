# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Architecture Overview

This is a modular Neovim configuration built with **lazy.nvim** as the plugin manager. The configuration follows a clean separation of concerns with distinct modules for different aspects of the editor.

### Core Structure
- **`init.lua`**: Entry point that sets mapleader, loads user modules, and initializes lazy.nvim
- **`lua/user/`**: Core user configuration modules (options, keymaps, autocmds)
- **`lua/plugin/`**: Individual plugin configurations loaded by lazy.nvim
- **`lazy-lock.json`**: Plugin version lockfile managed by lazy.nvim
- **`.luarc.json`**: Lua LSP configuration for Neovim development

### Plugin Architecture
The configuration uses lazy.nvim's modular loading system where each file in `lua/plugin/` returns a table of plugin specifications. Key plugin categories:
- **LSP & Completion**: Mason ecosystem for LSP management, nvim-cmp for completions
- **UI**: Catppuccin theme, lualine statusline, telescope fuzzy finder
- **Development**: Treesitter for syntax highlighting, conform.nvim for formatting, nvim-lint for linting
- **Java Development**: Special JDTLS setup with debugging capabilities

## Common Commands

### Plugin Management
```bash
# Install/update all plugins
nvim +Lazy

# Check plugin status
nvim +"Lazy show"

# Update plugins and lockfile
nvim +"Lazy update"

# Sync plugins to lockfile versions
nvim +"Lazy sync"

# Clean unused plugins
nvim +"Lazy clean"
```

### Configuration Development
```bash
# Test configuration changes
nvim --clean -u init.lua

# Check Lua syntax
luacheck lua/

# Format Lua files (if stylua is installed)
stylua lua/ init.lua

# Reload configuration without restart
# Inside nvim: :source ~/.config/nvim/init.lua
```

### LSP and Mason
```bash
# Open Mason interface
nvim +"Mason"

# Install specific LSP server
nvim +"MasonInstall lua_ls"

# Check LSP server status
nvim +"LspInfo"

# Update Mason packages
nvim +"MasonUpdate"
```

### Development Workflow Testing
```bash
# Test with minimal config
nvim --clean -u init.lua

# Test specific plugin
nvim -c "lua require('plugin.telescope')"

# Debug lazy loading
nvim +"Lazy profile"
```

## Key Configuration Patterns

### User Module Structure
- **`lua/user/option.lua`**: Editor options (numbers, tabs, cursor, etc.)
- **`lua/user/keymap.lua`**: Global keymaps (leader key set to space)
- **`lua/user/autocmd.lua`**: Autocommands for file handling and editor behavior

### Plugin Configuration Pattern
Each plugin file follows this structure:
```lua
return {
  {
    "plugin/name",
    dependencies = { ... },
    config = function()
      -- Plugin setup
    end,
  }
}
```

### Java Development Setup
The configuration includes specialized Java support:
- **JDTLS**: Eclipse JDT Language Server with debugging
- **DAP**: Debug Adapter Protocol configuration
- **Workspace**: Uses `~/.cache/jdtls/workspace` for project data

### LSP Integration
- **Mason**: Automatic LSP server management
- **Capabilities**: CMP integration for enhanced completions
- **Handlers**: Lua LS with vim globals, JDTLS with project detection
- **Keymaps**: Standard LSP bindings (gd, gr, K, <leader>ca, <leader>rn)

### Formatting and Linting
- **Conform.nvim**: Multi-language formatting with format-on-save
- **nvim-lint**: Asynchronous linting with auto-trigger on save
- **Mason-tool-installer**: Automatic tool installation

## Important File Relationships

- `init.lua` → `user/*` → `plugin/*` (loading hierarchy)
- `lazy-lock.json` ↔ `lua/plugin/*.lua` (version management)
- `.luarc.json` → LSP configuration for this repository
- `ftplugin/java.lua` → Java-specific settings

## Keybinding Conventions

- **Leader key**: `<Space>`
- **Quick exit insert**: `jj`
- **File operations**: `<leader>w` (save), `<leader>q` (quit)
- **Telescope**: `<leader>ff` (find files), `<leader>fg` (live grep), `<leader><leader>` (oldfiles)
- **LSP**: `gd` (definition), `gr` (references), `K` (hover), `<leader>ca` (code action), `<leader>rn` (rename)
- **Formatting**: `<leader>hf` (format buffer)
- **Linting**: `<leader>l` (trigger lint)

## Development Notes

### Plugin Loading
- Lazy.nvim auto-detects plugin files in `lua/plugin/`
- Each file should return a table of plugin specs
- Dependencies are handled automatically

### LSP Configuration
- Mason manages LSP servers automatically
- Custom server configs go in the mason-lspconfig handlers
- Java projects require proper root detection (pom.xml, build.gradle, .git)

### Troubleshooting
- Check `:checkhealth` for configuration issues
- Use `:Lazy profile` to debug slow loading
- `:LspLog` for LSP server debugging
- Mason logs available in `:Mason` interface
