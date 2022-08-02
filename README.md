# company-spell

A `company-mode` backend for any CLI spellchecker. Unlike `company-ispell` which requires a plaintext dictionary, this just pipes results from a spellchecking command on your computer. I have not run into any notable performance issues with this approach.

## Instructions

1. Install `aspell` for your *nix machine
2. Clone the library and load it like this:
```
(add-to-list 'load-path "~/.emacs.d/local/company-aspell")
(require 'company-aspell)
```
4. Once loaded:
```
(add-to-list 'company-backends  'company-aspell t)
```
5. Uses `aspell` by default, but you can set `hunspell` or `ispell` easily:
```
(setf company-aspell-command "hunspell")
;; or
(setf company-aspell-command "ispell")
```
6. You can modify the commands sent to the spellchecker like this:
```
(setf company-aspell-args "-a")
```


Now `company-aspell` will run on any buffer that has enabled both `company-mode` and `flyspell-mode`.
