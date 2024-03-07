(local {: autoload} (require :nfnl.module))

(fn cfg []
  (let [null-ls (autoload :null-ls)]
    (null-ls.setup
      {:sources
       [null-ls.builtins.formatting.stylua
        null-ls.builtins.formatting.fnlfmt
        null-ls.builtins.diagnostics.eslint
        null-ls.builtins.completion.spell]})))

[{1 :nvimtools/none-ls.nvim
  :config cfg}]
