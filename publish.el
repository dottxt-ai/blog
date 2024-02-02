;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)
(package-install 'find-lisp)
(package-install 'org)
(package-install 's)
(package-install 'zenburn-theme)

(require 's)
(require 'ox-publish)
(require 'find-lisp)

(load-theme 'zenburn t)

(setq make-backup-files nil)

(defun my/sitemap-format-entry (entry style project)
    (format "%s [[file:%s][%s]]"
            (format-time-string "%Y-%m-%d" (org-publish-find-date entry project))
            entry
            (org-publish-find-title entry project)))

(setq org-html-validation-link nil ;; Do not show "Validate" link
      org-confirm-babel-evaluate nil)
;; The following setting is to ask htmlize to output HTML with
;; classes instead of defining the theme inline
;; (setq org-html-htmlize-output-type 'css) ; default: 'inline-css

(setq org-publish-project-alist
      '(
        ("blog"
         :author "dottxt, Inc."
         :email "contact@thetypicalset.com"
         :with-email t
         :base-directory "org"
         :with-date t
         :publishing-directory "_public"
         :recursive nil
         :publishing-function org-html-publish-to-html
         :html-head-include-scripts nil
         :html-head-include-default-style nil
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\" /><script data-goatcounter='https://dottxt-blog.goatcounter.com/count' async src='//gc.zgo.at/count.js'></script>"
         :section-numbers nil
         :htmlized-source t
         :with-toc nil
         :html-postamble "<div id='mc_embed_shell'>
                <div id='mc_embed_signup'>
                <form action='https://dottxt.us12.list-manage.com/subscribe/post?u=aec344375257ff07dcf9a6ef6&amp;id=922982b042&amp;f_id=00db4ee0f0' method='post' id='mc-embedded-subscribe-form' name='mc-embedded-subscribe-form' class='validate' target='_self' novalidate=''>
                        <div id='mc_embed_signup_scroll'><h2>Keep up with structured generation</h2>
                        <div class='mc-field-group'><label for='mce-EMAIL'>Email Address </label><input type='email' name='EMAIL' class='required email' id='mce-EMAIL' required='' value=''><span id='mce-EMAIL-HELPERTEXT' class='helper_text'></span></div>
                        <div id='mce-responses' class='clear'>
                        <div class='response' id='mce-error-response' style='display: none;'></div>
                        <div class='response' id='mce-success-response' style='display: none;'></div>
                        </div><div aria-hidden='true' style='position: absolute; left: -5000px;'><input type='text' name='b_aec344375257ff07dcf9a6ef6_922982b042' tabindex='-1' value=''></div><div class='clear'><input type='submit' name='subscribe' id='mc-embedded-subscribe' class='button' value='Subscribe'></div>
                </div>
                </form>
                </div>
                </div>"
         :auto-sitemap t
         :sitemap-title ".txt engineering"
         :sitemap-filename "index.org"
         :sitemap-format-entry my/sitemap-format-entry
         :sitemap-sort-files anti-chronologically
         :sitemap-file-entry-format "%d - %t"
         :sitemap-style list)

        ; All figures, javascript scipts, etc linked to posts
        ("static"
        :base-directory "org"
        :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|svg\\|pdf\\|mp3\\|ogg\\|swf"
        :publishing-directory "_public/"
        :recursive t
        :publishing-function org-publish-attachment
        )
        ; The website's assets
        ("assets"
        :base-directory "assets"
        :base-extension any
        :publishing-directory "_public/"
        :recursive t
        :publishing-function org-publish-attachment
        )
        ("org" :components ("blog" "static" "assets"))))


; ---------------------------------------------------------------------
;                          PUBLISH
; ---------------------------------------------------------------------

(defun my/publish-all()
  (call-interactively 'org-publish-all))
