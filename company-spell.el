;; company-spell.el --- Autocompleting spelling for Company  -*- lexical-binding:t; coding:utf-8 -*-

;; Copyright (C) enzu.ru

;; Homepage: https://enzu.ru
;; Keywords: wp

;; Package-Version 1.0.0-git
;; Package-Requires: (
;;     (emacs "24.3")
;;     (cl-lib "1.0")
;;     (company "0.8.0"))

;; SPDX-License-Identifier: GPL-3.0

;;; Commentary:

;; A simple company backend that lets you use a terminal spellchecker

;;; Code:

(require 'company)
(require 'cl-lib)

(defcustom company-spell-command "aspell"
  "Usually a command string specifying aspell, hunspell, or ispell."
  :type 'function)

(defcustom company-spell-args "-a"
  "Args for the spelling command string; also a string."
  :type 'function)

(defgroup company-spell nil
  "Completion backend using a terminal spellchecker of your choice."
  :group 'company)

(defun company-spell--lookup-words (word &optional lookup-dict)
  "Use a terminal spellchecker to lookup words."
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
  "Spellchecking from your terminal to Company."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-spell))
    (prefix (when (derived-mode-p 'text-mode)
              (company-grab-symbol)))
    (candidates (company-spell--lookup-words arg))
    (kind 'text)
    (sorted t)))

(provide 'company-spell)

;;; company-spell.el ends here
