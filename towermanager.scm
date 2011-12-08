;;tower manager



;(define (random-point)
;  (let ((p (MathUtil.NoiseVector 15)))
;    (if (< (magnitude p) 8)
;	p
;	(random-point))))
(define count 0)

(define ground-plane (first (filter (lambda (x) (is? x GroundPlane)) game.Components)))

(define serial-number 0)
(define (make-name)
  (set! serial-number (+ serial-number 1))
  (String.Format "Adult{0}" serial-number))

(define (get-name)
  (String.Format  "Adult{0}" serial-number))



(define towerlist
  (list @(0 0 0)))


(define-state-machine managetowers
  ;;change ths number to control distance between towers
  (idle (when (mouse-left-down?) (when (every (lambda (x) (> (magnitude (- x ground-plane.MouseProjection)) 3)) towerlist)
                                   (cond ((>= gold 25)
                                          (within (new-twig-object Child (make-name) 1 ground-plane.MouseProjection @(0 0 1))
                                                  (set! gold (- gold 25))
                                                  (titles.say (String.Format "Gold: {0}" gold))
                                                  (define-state-machine click-annoyance
                                                    (start (messages ((click-left-on? this)
                                                                      (this.Say "Right click to upgrade or left click to view stats")
                                                                      (goto stage1))))
                                                    (stage1 (messages ((click-left-on? this)
                                                                       (this.Say "attack speed = 1")
                                                                       (goto start))
                                                                      ((click-right-on? this)
                                                                       (cond ((>= gold 50)
                                                                              (this.Say "attack speed = 2")
                                                                              (set! gold (- gold 50))
                                                                              (titles.say (String.Format "Gold: {0}" gold))
                                                                              (set! this.Color Color.Purple)
                                                                              (goto stage2))
                                                                             (else (this.Say "not enough gold")
                                                                                   (goto start))))))
                                                    (stage2 (messages ((click-left-on? this)
                                                                       (this.Say "Right click to upgrade or left click to view stats")
                                                                       (goto stage3))))
                                                    (stage3 (messages ((click-left-on? this)
                                                                       (this.Say "attack speed = 2")
                                                                       (goto stage2))
                                                                      ((click-right-on? this)
                                                                       (cond ((>= gold 100)
                                                                              (this.Say "attack speed = 3")
                                                                              (set! gold (- gold 100))
                                                                              (titles.say (String.Format "Gold: {0}" gold))
                                                                              (set! this.Color Color.Blue)
                                                                              (goto stage4))
                                                                             (else (this.Say "not enough gold")
                                                                                   (goto stage2))))))
                                                    (stage4 (messages ((click-left-on? this)
                                                                       (this.Say "attack speed = 3")
                                                                       (goto stage4))))
                                                    )
                                                  (define aStump '())
                                                  (define range 5)
                                                  (set! this.Cloaked true)
                                                  (define-twig-object aPen Pen @(0 1 7))
                                                  (define-state-machine attack
                                                    (acquire-target (enter  
                                                                     (set! aStump (this.Nearest (lambda (object) (is? object Ball))))
                                                                     (set-timeout 0))
                                                                    (messages (TimeoutMessage (cond ((null? aStump)  (goto acquire-target))
                                                                                                    ((< range (distance this.Position aStump.Position))  (goto acquire-target))
                                                                                                    (else  (goto initial-face)))))) ;(goto acquire-target))));
                                                    
                                                    (initial-face (enter 
                                                                   (set! this.FacingDirection aStump.Position)
                                                                   (set-timeout 0))
                                                                  (messages (TimeoutMessage (goto initial-raise-arms))))
                                                    (initial-raise-arms (enter
                                                                         (set-timeout 0))
                                                                        (messages (TimeoutMessage (goto prep))))
                                                    (prep (enter
                                                           (set! aPen.Position (+ this.Head.Midpoint @(0 1 0)))
                                                           (set-timeout 0))
                                                          (messages (TimeoutMessage  (goto aim))))
                                                    (aim (enter (set-timeout 0))
                                                         (messages (TimeoutMessage (goto fire))))
                                                    (fire (enter (set-timeout 0) (set! aPen.Velocity 
                                                                                       (* 5 (unit (- aStump.Position aPen.Position)))))
                                                          (messages 
                                                           (TimeoutMessage 
                                                            (cond ((< aPen.Position.Y 0.1) (goto acquire-target))
                                                                  ((> (distance aPen.Position aStump.Position) 1) (goto fire))
                                                                  ((< (distance aPen.Position aStump.Position) 1) (goto hit)))))) 
                                                    (hit (enter 
                                                          (aStump.walk-path.SetState "default")
                                                          (set! gold (+ 1 gold))
                                                          (set-timeout 0))
                                                         (messages (TimeoutMessage (goto acquire-target))))
                                                    (end (enter (this.Say "DONE WITH THIS SHIT") (set-timeout 0))
                                                         (messages (TimeoutMessage (goto end)))))
                                                  )
                                          (set! towerlist (cons ground-plane.MouseProjection towerlist)))
                                         (else (announcer.say "not enough gold")
                                               ))))))



;(for-each (lambda (x) (within x ((define-state-machine click-annoyance
;  (start (messages ((click-left-on? this)
;                    (this.Say "Please interact with me via the prompt.")
;                    (goto stage1))))
;  (stage1 (messages ((click-left-on? this)
;                     (this.Say "I am not able to process pointer-based input.")
;                     (goto stage2))))
;  (stage2 (messages ((click-left-on? this)
;                     (this.Say "Seriously, stop clicking on me. It won't get anything done.")
;                     (goto stage3))))
;  (stage3 (messages ((click-left-on? this)
;                     (this.Say "For the LAST time, STOP clicking on me!")
;                     (goto stage4))))
;  (stage4 (messages ((click-left-on? this)
;                     (this.Say "I can't deal with this.")
;                     (goto done)
;                     (dialog.SetState "done"))))
;  (done (messages ((click-left-on? this)
;                   (this.Say "I can't deal with this."))))))'(count))
;
;  (moveCameraUp (enter (set-timeout 0))
;                (messages (TimeoutMessage (set! gameCamera.Position.Z (+ gameCamera.Position.Z ;1)) (announcer.Say "hi!") (goto idle))))
;  (moveCameraDown (enter (set-timeout 0))
;                  (messages (TimeoutMessage (set! gameCamera.Position.Z (- ;gameCamera.Position.Z 1)) (goto idle))))
;  (moveCameraLeft (enter (set-timeout 0))
;                  (messages (TimeoutMessage (set! gameCamera.Position.X (+ ;gameCamera.Position.X 1)) (goto idle))))
;  (moveCameraRight (enter (set-timeout 0))
;                   (messages (TimeoutMessage (set! gameCamera.Position.X (- ;gameCamera.Position.X 1)) (goto idle)))))