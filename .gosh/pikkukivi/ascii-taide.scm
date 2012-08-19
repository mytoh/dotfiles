

(define-module pikkukivi.ascii-taide
  (export
    ascii-taide)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  (use kirjasto.tiedosto)
  (use kirjasto.väri))
(select-module pikkukivi.ascii-taide)

(define ascii-directory
  (build-path (home-directory) ".aa"))

(define (file-is-aa? name)
  (if (string=? "aa" (path-extension name))
    #t
    #f))

(define (ascii-taide args)
  (cat-file
    (map (lambda (f)
           (find-file-in-paths (path-swap-extension f "aa")
                               :paths `(,(expand-path ascii-directory))
                               :pred file-is-aa?))
         args)))
