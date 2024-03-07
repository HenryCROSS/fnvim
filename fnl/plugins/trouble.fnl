(local {: autoload} (require :nfnl.module))

(local kset vim.keymap.set)

(fn cfg []
  (let [trouble (autoload :trouble)]
    (kset :n :<leader>xx (fn []
                           (trouble.toggle)))
    (kset :n :<leader>xw (fn []
                           (trouble.toggle :workspace_diagnostics)))
    (kset :n :<leader>xd (fn []
                           (trouble.toggle :document_diagnostics)))
    (kset :n :<leader>xq (fn []
                           (trouble.toggle :quickfix)))
    (kset :n :<leader>xl (fn []
                           (trouble.toggle :loclist)))
    (kset :n :gR (fn []
                   (trouble.toggle :lsp_references)))))

[{1 :folke/trouble.nvim
  :dependencies [:nvim-tree/nvim-web-devicons]
  :config cfg}]
