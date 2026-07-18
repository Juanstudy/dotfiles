return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      dir_path = function()
        return vim.fn.expand("~/Obsidian/Zettelkasten/files")
      end,
      use_absolute_path = false,
      relative_to_current_file = true,
      prompt_for_file_name = false,
      insert_mode_after_paste = true,
      use_cursor_in_template = true,
    },
    filetypes = {
      markdown = {
        url_encode_path = true,
        template = "![$CURSOR]($FILE_PATH)",
        download_images = false,
      },
    },
  },
  keys = {
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
  },
}
