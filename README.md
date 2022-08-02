# company-aspell

A `company-mode` backend for `aspell`. Unlike `company-ispell` which requires a plaintext dictionary, this just pipes results from the `aspell` command on your computer. I have not run into any notable performance issues with this approach.

## Instructions

1. Install `aspell` for your *nix machine
2. Clone the library and load it like this:
```
(add-to-list 'load-path "~/.emacs.d/local/company-aspell")
(require 'company-aspell)
```
3. Once loaded:
```
(add-to-list 'company-backends  'company-aspell t)
```

Now `company-aspell` will run on any buffer that has enabled both `company-mode` and `flyspell-mode`.
