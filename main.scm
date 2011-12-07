(cd-here)

(require 'state-machines)

(define-twig-object announcer Adult @(0 0 0) @(0 0 1)
  Color: Color.Red)

;;(within announcer
;;  (load "announcer.scm"))

(define-twig-object gameCamera Camera)

(within gameCamera
        (load "camera.scm"))