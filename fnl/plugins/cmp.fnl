(local {: autoload} (require :nfnl.module))

(local cmp-src-menu-items
  {:buffer "buff"
   :nvim_lsp "lsp"
   :vsnip "vsnp"
   :luasnip "lsnp"})

(local cmp-srcs
  [{:name :nvim_lsp}
   {:name :buffer}
   {:name :vsnip}
   {:name :luasnip}])

(fn has-words-before []
  (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
    (and (not= col 0)
         (= (: (: (.
                   (vim.api.nvim_buf_get_lines 0 (- line 1) line true)
                   1) :sub col col) :match "%s") nil))))

(fn cfg []
  (let [cmp (require :cmp)
        luasnip (require :luasnip)
        lspkind (autoload :lspkind)]
    (cmp.setup {:formatting
                {:format (lspkind.cmp_format
                           {:mode :symbol_text
                            :menu {:buffer "[Buffer]"
                                   :nvim_lsp "[LSP]"
                                   :luasnip "[LuaSnip]"
                                   :nvim_lua "[Lua]" }
                            :maxwidth 50
                            :ellipsis_char "..."
                            :show_labelDetails true })}
                :mapping {:<C-p> (cmp.mapping.select_prev_item)
                          :<C-n> (cmp.mapping.select_next_item)
                          :<C-b> (cmp.mapping.scroll_docs (- 4))
                          :<C-f> (cmp.mapping.scroll_docs 4)
                          :<C-Space> (cmp.mapping.complete)
                          :<C-e> (cmp.mapping.close)
                          :<CR> (cmp.mapping.confirm
                                  {:behavior cmp.ConfirmBehavior.Insert
                                   :select true})
                          :<Tab> (cmp.mapping
                                   (fn [fallback]
                                     (if
                                       (cmp.visible) (cmp.select_next_item)
                                       (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
                                       (has-words-before) (cmp.complete)
                                       :else (fallback)))
                                   {1 :i 2 :s})
                          :<S-Tab> (cmp.mapping
                                     (fn [fallback]
                                       (if
                                         (cmp.visible) (cmp.select_prev_item)
                                         (luasnip.jumpable -1) (luasnip.jump -1)
                                         :else (fallback)))
                                     {1 :i 2 :s})}
                :snippet {:expand (fn [args]
                                    (luasnip.lsp_expand args.body))}
                :sources cmp-srcs})

    (cmp.setup.cmdline
      [:/ :?]
      {:mapping (cmp.mapping.preset.cmdline)
       :source {:name "buffer"}})))

[{1 :hrsh7th/nvim-cmp
  :dependencies [:hrsh7th/cmp-buffer
                 :hrsh7th/cmp-nvim-lsp
                 :hrsh7th/cmp-vsnip
                 :L3MON4D3/LuaSnip
                 :saadparwaiz1/cmp_luasnip

                 :hrsh7th/cmp-cmdline
                 :hrsh7th/cmp-path]
  :config cfg}
 {1 :onsails/lspkind.nvim
  :dependencies [:hrsh7th/nvim-cmp]}]