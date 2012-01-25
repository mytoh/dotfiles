#!/usr/bin/env gosh

#;"original script -> gist.github.com/1261116"

(use gauche.process)
(use file.util)
(use kirjasto)

(let* ((hook-dir (current-directory)) #;"git_hook directory"
       (proc-dir (resolve-path (build-path hook-dir 'up 'up))) #;"vimproc directory"
       (proc-make (lambda (file)
                    (current-directory proc-dir)
                      (run-process `(make -f ,file clean all) :wait #t))))
       (case (get-os-type)
         ((darwin)  (proc-make "make_mac.mak"))
         ((freebsd) (proc-make "make_gcc.mak"))
         ((linux)   (proc-make "make_gcc.mak"))
         (else (print "this os is not supported"))))
