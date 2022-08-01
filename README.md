# company-aspell

A company-mode backend for aspell.

Load it like this:

```
(add-to-list 'load-path "~/.emacs.d/local/company-aspell")
(require 'company-aspell)
```

Once loaded:

```
(push 'company-aspell company-backends)
```

It will run on any buffer that has `flyspell-mode` enabled.
