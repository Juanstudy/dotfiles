return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  enabled = function()
    return not vim.g.disable_obsidian
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "Zettelkasten",
        path = vim.fn.expand("~/Obsidian/Zettelkasten/"),
      },
    },
    completion = {
      cmp = true,
      min_chars = 2,
    },
    picker = {
      name = "snacks.pick",
    },
    -- New notes default to inbox (quick captures)
    new_notes_location = "inbox",
    attachments = {
      folder = "files",
    },
    -- Disable daily notes — not used in Zettelkasten
    daily_notes = {
      enabled = false,
    },
    -- Custom ID generation: yyyymmdd-slug
    ---@param title string|nil
    ---@return string
    note_id_func = function(title)
      local date = os.date("%Y%m%d")
      if title and title ~= "" then
        local slug = title:lower()
        slug = slug:gsub("[^%w%s-]", "")
        slug = slug:gsub("%s+", "-")
        slug = slug:gsub("-+", "-")
        slug = slug:gsub("^-", "")
        slug = slug:gsub("-$", "")
        if #slug > 40 then
          slug = slug:sub(1, 40)
          slug = slug:gsub("-+$", "")
        end
        return date .. "-" .. slug
      end
      local suffix = ""
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(97, 122))
      end
      return date .. "-" .. suffix
    end,
    -- Moved from deprecated note_frontmatter_func to frontmatter.func
    frontmatter = {
      func = function(note)
        local type_by_subdir = {
          inbox = "inbox",
          notes = "evergreen",
          maps = "map",
        }
        local note_type = type_by_subdir[note.subdir or ""] or "inbox"

        local frontmatter = {
          id = note.id,
          title = note.title or "Untitled",
          type = note_type,
          status = note_type == "map" and "active" or "draft",
          tags = {},
          aliases = {},
          created = os.date("%Y-%m-%d"),
          updated = os.date("%Y-%m-%d"),
        }

        if note_type == "literature" or note_type == "source" then
          frontmatter.source = vim.NIL
        end
        if note_type == "evergreen" or note_type == "area" or note_type == "project" then
          frontmatter.related = vim.NIL
        end

        return frontmatter
      end,
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      tags = "",
    },
    callbacks = {
      enter_note = function(note)
        if not note then
          return
        end
        vim.keymap.set("n", "gf", function()
          return require("obsidian").util.gf_passthrough()
        end, { buffer = note.bufnr, expr = true, desc = "Follow link" })
        vim.keymap.set("n", "<leader>ch", function()
          return require("obsidian").util.toggle_checkbox()
        end, { buffer = note.bufnr, desc = "Toggle checkbox" })
        vim.keymap.set("n", "<cr>", function()
          return require("obsidian").util.smart_action()
        end, { buffer = note.bufnr, expr = true, desc = "Smart action" })
        vim.keymap.set("n", "<leader>bl", function()
          vim.cmd("Obsidian backlinks")
        end, { buffer = note.bufnr, desc = "Toggle backlinks" })
      end,
    },
  },
  keys = {
    -- Quick capture to inbox (prompts for title)
    {
      "<leader>oi",
      function()
        local input = vim.fn.input("Inbox title: ")
        if input and input ~= "" then
          vim.cmd("Obsidian new inbox/ " .. input)
        else
          vim.cmd("Obsidian new inbox/")
        end
      end,
      desc = "Inbox capture",
    },
    -- New processed note in notes/
    {
      "<leader>on",
      function()
        local input = vim.fn.input("Note title: ")
        if input and input ~= "" then
          vim.cmd("Obsidian new notes/ " .. input)
        end
      end,
      desc = "New processed note",
    },
    -- New map in maps/
    {
      "<leader>om",
      function()
        local input = vim.fn.input("Map title: ")
        if input and input ~= "" then
          vim.cmd("Obsidian new maps/ " .. input)
        end
      end,
      desc = "New map note",
    },
    -- Search notes by title
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    -- Search notes by content
    { "<leader>og", "<cmd>Obsidian grep<cr>", desc = "Grep notes" },
    -- Backlinks for current note
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Toggle backlinks" },
    -- Follow link under cursor
    { "<leader>ol", "<cmd>Obsidian follow_link<cr>", desc = "Follow link" },
    -- Tag search
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Search tags" },
    -- Open link in split
    { "<leader>ov", "<cmd>Obsidian follow_link hsplit<cr>", desc = "Follow link (split)" },
    -- Today (actually follows daily note link — disabled but mapped)
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Today (disabled)" },
  },
}
