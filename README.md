# company-spell
[![GNU Emacs](https://img.shields.io/static/v1?logo=gnuemacs&logoColor=fafafa&label=Made%20for&message=GNU%20Emacs&color=7F5AB6&style=flat)](https://www.gnu.org/software/emacs/)
[![MELPA](https://melpa.org/packages/company-spell-badge.svg)](https://melpa.org/#/company-spell)

![A dropdown selection in Emacs with word suggestions](doc/example.gif)

**If you are happy with company-ispell, this package is not for you, and you are encouraged to stick with company-ispell.**

`company-spell` is a hackable minimalist framework for spellchecking. 

`company-spell` directly uses your spellcheck program with no questions asked, and is compatible with ispell, aspell, and hunspell. Unlike `company-ispell`, this works outside of the [default Emacs ispell machinery](https://www.gnu.org/software/emacs/manual/html_node/emacs/Spelling.html).

To get a sense of the difference, compare company-spell's minimalist [spellchecking function](https://github.com/enzuru/company-spell/blob/4866da9780ed8260734ec8f7fb3054a48c2bf297/company-spell.el#L36) with [that of Emacs ispell](https://github.com/emacs-mirror/emacs/blob/7055fd8e43eebab5ad27c665a941d0612da7f173/lisp/textmodes/ispell.el#L2507).

This minimalist approach that keeps less machinery between you and your spellchecker, and allows you to cultivate your in buffer spellchecking with a different approach than spellchecking elsewhere.

I have not discovered any notable performance issues with this approach, and in fact, I have anecdotally found it to be faster than company-spell (no promises though!). aspell is the default because I find that it returns the best results.

It will automatically run on any buffer that has a major mode derived from `text-mode`, which includes almost all modes meant for human writing.

## Instructions

### Preparation

Ensure a terminal spellchecker is installed (`aspell`, `hunspell`, `ispell`, etc) and that you have access to [MELPA](https://melpa.org/#/getting-started).

### Installation

#### package-install

```elisp
M-x package-install company-spell
(push 'company-spell company-backends)
```

#### use-package

```elisp
(use-package company-spell
  :config (push 'company-spell company-backends)
  :ensure t)
```

### Configuration

#### company-spell-command

Optionally, set a spellchecker that isn't the default value of `aspell`:
```elisp
(setf company-spell-command "hunspell")
;; or
(setf company-spell-command "ispell")
```

#### comapny-spell-args

You can further customize your results by setting custom args (only `-a` is enabled by default). For instance, search via "soundslike":
```elisp
(setf company-spell-args "-a soundslike")
```

#### company-spell-filter

You might want to setup your own filter. This is a simple function that takes in the results of your spellcheck command with its arguments, and turns it into a list for Company.
```elisp
(setf company-spell-filter #'my-filtering-function)
```
