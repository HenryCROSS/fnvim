(local {: autoload} (require :nfnl.module))
(import-macros
  {: kset! }
  :config/macro)

;; split screen
(kset! :n :<leader>ws :<cmd>sp<cr> {:desc "horizontal split"})
(kset! :n :<leader>wv :<cmd>vsp<cr> {:desc "vertical split"})

(kset! :n :<leader>wq :<c-w>q<cr> {:desc "quit screen"})

{}
