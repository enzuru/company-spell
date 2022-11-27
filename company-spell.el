;;; company-spell.el --- company-mode completion for most major terminal spellcheckers

;; Author: Ahmed Khanzada

;;; Commentary:
;;

;;; Code:

(require 'company)
(require 'cl-lib)

(defvar company-spell-command "aspell")
(defvar company-spell-args "-a")
(defvar company-spell-delay "1 sec")

(defgroup company-spell nil
  "Completion backend using a terminal spellchecker of your choice"
  :group 'company)

(defun company-spell--buffer-missing (bufname) (eq nil (get-buffer bufname)))

(defun company-spell--buffer-name (arg)
  (concat " company-spell-" arg "*"))

(defun company-spell--lookup-words (arg)
  (interactive)
  (if arg
      (let ((async-buffer-name (company-spell--buffer-name arg)))
        (if (not (company-spell--buffer-missing async-buffer-name))
            (with-current-buffer async-buffer-name
              (if (not (eq (buffer-end 1) (buffer-end -1)))
                  (let ((results (split-string (buffer-substring-no-properties 1 (buffer-end 1)) ",")))
                    (if (> (length results) 0)
                        (progn
                          (setf (nth 0 results)
                                (nth 0 (last (split-string (nth 0 results)))))
                          (let ((trimmed-results
                                 (cl-map 'list 'string-trim results)))
                            (if (not (string-equal (nth 0 trimmed-results) "*"))
                                trimmed-results
                              '())))
                      '()))
                '()))
          '()))
    '()))

(defun company-spell--interactive (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-spell))
    (prefix (when (derived-mode-p 'text-mode) (company-grab-symbol)))
    (candidates (company-spell--lookup-words arg))
    (kind 'text)
    (sorted t)))

;;;###autoload
(defun company-spell (command &optional arg &rest ignored)
  "company-mode completion backend using Spell."
  (interactive (list 'interactive))
  (cl-case command
    (candidates
     (progn
       (if arg (let* ((spell-command
                       (format "echo \"%s\" | %s %s"
                               arg
                               company-spell-command
                               company-spell-args))
                      (async-buffer-name (company-spell--buffer-name arg)))
                 (if (company-spell--buffer-missing async-buffer-name)
                     (progn
                       ;; (async-shell-command spell-command async-buffer-name)
                       ;; (run-at-time company-spell-delay nil 'message (company-grab-symbol))
                       ;; (run-at-time company-spell-delay nil 'company-complete)
                       )))))))
  (company-spell--interactive command arg))

(provide 'company-spell)
