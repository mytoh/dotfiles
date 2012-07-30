#!/usr/bin/env gosh

#;"original script -> gist.github.com/1261116"

(use gauche.process)
(use file.util)
(use util.match)
(use kirjasto) ; get-os-type

(let* ((hook-dir (current-directory)) #;"git_hook directory"
       (proc-dir (resolve-path (build-path hook-dir 'up 'up))) #;"vimproc directory"
       (proc-make (lambda (file)
                    (current-directory proc-dir)
                      (run-process `(make -f ,file clean all) :wait #t))))
       (print "compiling library ...")
       (match (get-os-type)
         ('darwin  (proc-make "make_mac.mak"))
         ('freebsd (proc-make "make_unix.mak"))
         ('linux   (proc-make "make_unix.mak"))
         (_ (print "this os is not supported")))
       (print "done")
       (newline)
       (print "vimproc: build success!")
       (newline)
       (print "END POST-MERGE HOOK"))
