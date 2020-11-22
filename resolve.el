(defun resolve ()
  (interactive)
  (setq pos (point))
  (goto-char (point-min))
  (goto-char (- (search-forward "//INSERT ABOVE HERE") 19))
  (let (file buf str from to)
    (setq file (read-file-name "File Name: " "~/git-library/"))
    (setq buf (find-file-noselect file))
    (setq str
	  (with-current-buffer buf
	    (buffer-substring-no-properties (point-min) (point-max))))
    (setq from (+ (string-match "//BEGIN CUT HERE" str) 17))
    (setq to (+ (string-match "//END CUT HERE" str) 1))
    (insert
     (with-current-buffer buf
       (buffer-substring-no-properties from to)))
    (insert "\n")
    (setq pos (+ pos (- to from) 1)))
  (goto-char pos))

(define-key global-map (kbd "C-x l") 'resolve)
