:warning: Work in Progress!

# Introduction

A obsidian like markdown viewer, editor and linker and an excuse for me to learn lua and some neovim API

Powered under the hood by: [glow.nvim](https://github.com/ellisonleao/glow.nvim)
Also check out: [mkdnflow.nvim](https://github.com/jakewvincent/.nvim)

# Installation

```
  -- dragonglass
    use {
        'frroossst/dragonglass.nvim',
        requires = { {"ellisonleao/glow.nvim"} }
    }
    
```

# Usage

```
:lua require('dg').render() => renders the current markdown file and opens a preview window
:lua require('dg').follow() => opens the local file link in a new buffer [psuedoname](path_to_file)
```

NOTE: Prefer giving absolute paths, as relative paths might break when you're in different parent directories

# Roadmap
- [x] Edit and Render markdown
- [x] Render a clickable local link

# How it works?

## Normal mode
- view rendered markdown/HTML
- resolve local links

## Insert mode
- change raw markdown
