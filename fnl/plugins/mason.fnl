(local {: autoload} (require :nfnl.module))
(local mason (autoload :mason))
(local mason-lsp (autoload :mason-lspconfig))

(local lsp (require :config/lsp))

[{1 :williamboman/mason.nvim
  :config (fn []
            (let [mason (require :mason)]
              (mason.setup
                {:ui
                 {:icon
                  {:package_installed "✓"
                   :package_pending "➜"
                   :package_uninstalled "✗"}}})))}
 {1 :williamboman/mason-lspconfig.nvim
  :config (fn []
(mason-lsp.setup
  {:ensure_installed lsp}))}]
