(cd-here)

(require 'state-machines)
(define real-max-speed 20)
(define gold 150)
(define lives 100)
(define kills 0)
(define difficulty-scale 10)
(define-twig-object announcer Adult @(0 0 0) @(0 0 1)
  Color: Color.Red)
(load "HUDs.scm")

(titles.Say (String.Format "Gold: {0}  Lives: {1}" gold lives) 0.0 0.0)
(define all-characters (list announcer))

(define (random-point)
  (let ((p (MathUtil.NoiseVector 15)))
    (if (< (magnitude p) 8)
        p        
        (random-point))))

(define-twig-object gameCamera Camera)
(within announcer
        (load "intro.scm")
        
        (define-state-machine allgame
          (pre (when (key-down? Keys.Space) (goto post)))
          (post (enter 
                 (dialog.SetState "done") (set-timeout 0))
                (messages (TimeoutMessage (goto ready))))
          (ready (enter 
                  (load "level.scm")
                  (within gameCamera
                          (load "camera.scm")
                          (load "towermanager.scm"))
                  (load "enemies.scm")
                  ))))












