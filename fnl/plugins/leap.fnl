(local {: autoload} (require :nfnl.module))

(fn cfg []
  (vim.keymap.set [:n :x :o] :f "<Plug>(leap-forward)")
  (vim.keymap.set [:n :x :o] :F "<Plug>(leap-backward)"))

[{1 :ggandor/leap.nvim
  :dependencies [:tpope/vim-repeat]
  :config cfg}]
