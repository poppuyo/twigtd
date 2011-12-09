; by jason lee, john greene, josiah matlack
(cd-here)

; state machines, oh-so-necesary for all of our logic
(require 'state-machines)

; some global variables
;; bounds the MaximumSpeed property of an enemy
(define real-max-speed 20)
;; money holder
(define gold 150)
;; lives holder
(define lives 100)
;; kills holder
(define kills 0)
;; a difficulty scale (lower=harder, higher=easier)
(define difficulty-scale 25)

; our talkative host
(define-twig-object announcer Adult @(-35 0 -40) @(0 0 1)
  Color: Color.Red)

; HUD loader + default value
(load "HUDs.scm")
(titles.Say (String.Format "Gold: {0}  Lives: {1}" gold lives) 0.0 0.0)

; utility function for random vector3s
(define (random-point)
  (let ((p (MathUtil.NoiseVector 15)))
    (if (< (magnitude p) 8)
        p        
        (random-point))))

; a Camera object that will hold the camera functions and tower placement/logic
(define-twig-object gameCamera Camera)

; main game-state-machine
(within announcer
        ; initiate the introduction "show"
        (load "intro.scm")
        ; three states: pre/post/ready
        (define-state-machine allgame
          ; allows you to skip the intro
          (pre (when (key-down? Keys.Space) (goto post)))
          ; tells the intro to shut up
          (post (enter 
                 (dialog.SetState "done") (set-timeout 0))
                (messages (TimeoutMessage (goto ready))))
          ; load the actual game
          (ready (enter 
                  (load "level.scm")
                  (within gameCamera
                          (load "camera.scm")
                          (load "towermanager.scm"))
                  (load "enemies.scm")
                  ))))