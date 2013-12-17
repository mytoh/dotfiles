(use spiffy)

(parameterize ((server-port 8888) 
               (root-path "~/.site"))
  (start-server))

