(cd-here)

(require 'state-machines)
(define gold 150)
(define kills 0)
(define-twig-object announcer Adult @(0 0 0) @(0 0 1)
  Color: Color.Red)
(load "HUDs.scm")
(titles.say (String.Format "Gold: {0}" gold))
(define all-characters (list announcer))
;;(within announcer
;;  (load "announcer.scm"))


;(set! Physics.gVector @(0 0 0))

(define (random-point)
  (let ((p (MathUtil.NoiseVector 15)))
    (if (< (magnitude p) 8)
	p

	(random-point))))
;(for-each (lambda (ignore)
;            (new-component Stump (random-point)))
;          '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

(define-twig-object gameCamera Camera)


(within gameCamera
        (load "camera.scm")

(load "towermanager.scm"))

(load "enemies.scm")


;(define-twig-object fred Adult (ground-plane-mouse-location) @(0 0 1)
;  Color: Color.Red)







