;;; company-spell.el --- company-mode completion for most major terminal spellcheckers

;; Copyright (C) enzu.ru
;; SPDX-License-Identifier: GPL-3.0

;;; Code:

(require 'company)
(require 'cl-lib)

(defcustom company-spell-command "aspell"
  "Spelling command. Usually a string specifying aspell, hunspell, or ispell"
  :type 'function)

(defcustom company-spell-args "-a"
  "Args for spelling command"
  :type 'function)

(defgroup company-spell nil
  "Completion backend using a terminal spellchecker of your choice"
  :group 'company)

(defun company-spell--lookup-words (word &optional lookup-dict)
  (let* ((spell-command
          (format "echo \"%s\" | %s %s"
                  word
                  company-spell-command
                  company-spell-args))
         (results
          (split-string
           (shell-command-to-string spell-command) ",")))
    (setf (nth 0 results)
          (nth 0 (last (split-string (nth 0 results)))))
    (let ((trimmed-results (cl-map 'list 'string-trim results)))
      (if (not (string-equal (nth 0 trimmed-results) "*"))
          trimmed-results '()))))

;;;###autoload
(defun company-spell (command &optional arg &rest ignored)
  "company-mode completion backend using Spell."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-spell))
    (prefix (when (derived-mode-p 'text-mode)
              (company-grab-symbol)))
    (candidates (company-spell--lookup-words arg))
    (kind 'text)
    (sorted t)))

(provide 'company-spell)
