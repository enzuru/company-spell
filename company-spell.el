;;; company-spell.el --- company-mode completion for most major terminal spellcheckers

;; Author: Ahmed Khanzada

;;; Commentary:
;;

;;; Code:

(require 'company)
(require 'cl-lib)

(defvar company-spell-command "aspell")
(defvar company-spell-args "-a")

(defgroup company-spell nil
  "Completion backend using a terminal spellchecker of your choice"
  :group 'company)

(defun company-spell--lookup-words (word &optional lookup-dict)
  (let* ((spell-command
          (concat "echo '" word "' | " company-spell-command " " company-spell-args))
         (results
          (split-string (shell-command-to-string spell-command) ",")))
    (setf (nth 0 results)
          (nth 0 (last (split-string (nth 0 results)))))
    (let ((trimmed-results
           (cl-map 'list 'string-trim results)))
      trimmed-results)))

;;;###autoload
(defun company-spell (command &optional arg &rest ignored)
  "company-mode completion backend using Spell."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-spell))
    (prefix (when (bound-and-true-p flyspell-mode)
              (company-grab-symbol)))
    (candidates (company-spell--lookup-words arg))
    (kind 'text)
    (sorted t)))

(provide 'company-spell)
