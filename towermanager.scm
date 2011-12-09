;;tower manager

(define count 0)
(define ground-plane (first (filter (lambda (x) (is? x GroundPlane)) game.Components)))

;function to help us generate names (for [child] towers)
(define serial-number 0)
(define (make-name)
  (set! serial-number (+ serial-number 1))
  (String.Format "Adult{0}" serial-number))

; returns indexed-name
(define (get-name)
  (String.Format  "Adult{0}" serial-number))

; illegal placement locations for towers (too close/inside path)
; towers can't be placed within 3 distance of these vectors
(define towerlist
  (list @(0 0 0) @(-50 0 -50) @(-48 0 -50) @(-46 0 -50) @(-44 0 -50) @(-42 0 -50) @(-40 0 -50) @(-40 0 -52) @(-40 0 -54) @(-40 0 -56) @(-40 0 -58) @(-40 0 -60) @(-38 0 -60) @(-36 0 -60) @(-34 0 -60) 
        @(-32 0 -60) @(-30 0 -60) @(-30 0 -58) @(-30 0 -56) @(-30 0 -54) @(-30 0 -52) @(-30 0 -50) @(-30 0 -48) @(-30 0 -46) @(-30 0 -44) @(-30 0 -42) @(-30 0 -40) @(-30 0 -38) @(-30 0 -36) @(-30 0 -34)
        @(-30 0 -32) @(-30 0 -30) @(-28 0 -30) @(-26 0 -30) @(-24 0 -30) @(-22 0 -30) @(-20 0 -30) @(-18 0 -30) @(-16 0 -30) @(-14 0 -30) @(-12 0 -30) @(-10 0 -30) @(-8 0 -30) @(-6 0 -30) @(-4 0 -30)
        @(-2 0 -30) @(0 0 -30) @(0 0 -28) @(0 0 -26) @(0 0 -24) @(0 0 -22) @(0 0 -20) @(0 0 -18) @(0 0 -16) @(0 0 -14) @(0 0 -12) @(0 0 -10) @(0 0 -8) @(0 0 -6) @(0 0 -4) @(0 0 -2) @(20 0 0) @(18 0 0)
        @(16 0 0) @(14 0 0) @(12 0 0) @(10 0 0) @(8 0 0) @(6 0 0) @(4 0 0) @(2 0 0) @(20 0 30) @(20 0 28) @(20 0 26) @(20 0 24) @(20 0 22) @(20 0 20) @(20 0 18) @(20 0 16) @(20 0 14) @(20 0 12) @(20 0 10)
        @(20 0 8) @(20 0 6) @(20 0 4) @(20 0 2) @(10 0 30) @(12 0 30) @(14 0 30) @(16 0 30) @(18 0 30) @(10 0 40) @(10 0 32) @(10 0 34) @(10 0 36) @(10 0 38) @(0 0 40) @(2 0 40) @(4 0 40) @(6 0 40)
        @(8 0 40) @(-50 0 40) @(-48 0 40) @(-46 0 40) @(-44 0 40) @(-42 0 40) @(-40 0 40) @(-38 0 40) @(-36 0 40) @(-34 0 40) @(-32 0 40) @(-30 0 40) @(-28 0 40) @(-26 0 40) @(-24 0 40) @(-22 0 40)
        @(-20 0 40) @(-18 0 40) @(-16 0 40) @(-14 0 40) @(-12 0 40) @(-10 0 40) @(-8 0 40) @(-6 0 40) @(-4 0 40) @(-2 0 40)))

;; tower-managing state-machine
(define-state-machine managetowers
  ;;change ths number to control distance between towers (so you don't stack them)
  (idle (when (mouse-left-down?) (when (every (lambda (x) (> (magnitude (- x ground-plane.MouseProjection)) 3)) towerlist)
                                   ; can you afford a tower?
                                   (cond ((>= gold 25)
                                          ; make our new tower
                                          (within (new-twig-object Child (make-name) 1 ground-plane.MouseProjection @(0 0 1))
                                                  ; construction (resource+labor) fees
                                                  (set! gold (- gold 25))
                                                  ; reflect new data
                                                  (titles.say (String.Format "Gold: {0}  Lives: {1}" gold lives))
                                                  ; initialize attack speed to 8
                                                  (define gain 8)
                                                  ; state-machine to handle human-tower interactions
                                                  (define-state-machine click-actions
                                                    ; start with a left click
                                                    (start (messages ((click-left-on? this)
                                                                      (this.Say "Right click to upgrade or left click to view stats")
                                                                      (goto stage1))))
                                                    (stage1 (messages ((click-left-on? this)
                                                                       ; show tower stats
                                                                       (this.Say "attack speed = 1")
                                                                       (goto start))
                                                                      ((click-right-on? this)
                                                                       ; upgrade tower to level2
                                                                       ; take fees, change color, make attack speed double
                                                                       (cond ((>= gold 50)
                                                                              (this.Say "attack speed = 2")
                                                                              (set! gold (- gold 50))
                                                                              (titles.say (String.Format "Gold: {0}  Lives: {1}" gold lives))
                                                                              (set! this.Color Color.Purple)
                                                                              (set! gain (* gain 2))
                                                                              (goto stage2))
                                                                             (else (this.Say "not enough gold")
                                                                                   (goto start))))))
                                                    (stage2 (messages ((click-left-on? this)
                                                                       (this.Say "Right click to upgrade or left click to view stats")
                                                                       (goto stage3))))
                                                    (stage3 (messages ((click-left-on? this)
                                                                       ; show tower stats
                                                                       (this.Say "attack speed = 2")
                                                                       (goto stage2))
                                                                      ((click-right-on? this)
                                                                       ; upgrade tower to level3
                                                                       ; take fees, change color, make attack speed double
                                                                       (cond ((>= gold 100)
                                                                              (this.Say "attack speed = 3")
                                                                              (set! gold (- gold 100))
                                                                              (titles.say (String.Format "Gold: {0}  Lives: {1}" gold lives))
                                                                              (set! this.Color Color.Blue)
                                                                              (set! gain (* gain 2))
                                                                              (goto stage4))
                                                                             (else (this.Say "not enough gold")
                                                                                   (goto stage2))))))
                                                    (stage4 (messages ((click-left-on? this)
                                                                       ; show tower stats
                                                                       (this.Say "attack speed = 3")
                                                                       (goto stage4))))
                                                    )
                                                  
                                                  ;; begin tower attack logic code
                                                  
                                                  ; an enemy placeholder variable
                                                  (define aStump '())
                                                  ; acquisition range of a tower
                                                  (define range 5)
                                                  ; relieve some of the engine's stress
                                                  (set! this.Cloaked true)
                                                  ; prepare its projectile
                                                  (define-twig-object aPen Pen @(0 1 7))
                                                  ; acquire-attack-loop
                                                  (define-state-machine attack
                                                    (acquire-target (enter  
                                                                     ; find an enemy (type ball) to attack
                                                                     (set! aStump (this.Nearest (lambda (object) (is? object Ball))))
                                                                     (set-timeout 0))
                                                                    ; handle for: nothing to attack/too far to attack/found a target
                                                                    (messages (TimeoutMessage (cond ((null? aStump)  (goto acquire-target))
                                                                                                    ((< range (distance this.Position aStump.Position))  (goto acquire-target))
                                                                                                    (else  (goto initial-face)))))) ;(goto acquire-target))));
                                                    (initial-face (enter 
                                                                   ; face your enemy
                                                                   (set! this.FacingDirection aStump.Position)
                                                                   (set-timeout 0))
                                                                  (messages (TimeoutMessage (goto initial-raise-arms))))
                                                    ; used to be a 'raise-arms' animation here, but made things super jerky
                                                    (initial-raise-arms (enter
                                                                         (set-timeout 0))
                                                                        (messages (TimeoutMessage (goto prep))))
                                                    (prep (enter
                                                           ; teleport the ammunition to above the tower's "head"
                                                           (set! aPen.Position (+ this.Head.Midpoint @(0 1 0)))
                                                           (set-timeout 0))
                                                          (messages (TimeoutMessage  (goto aim))))
                                                    (aim (enter (set-timeout 0))
                                                         (messages (TimeoutMessage (goto fire))))
                                                    (fire (enter (set-timeout 0) (set! aPen.Velocity 
                                                                                       ; homing bullet
                                                                                       (* gain (unit (- aStump.Position aPen.Position)))))
                                                          (messages 
                                                           (TimeoutMessage 
                                                            ; handle for: projectile travelled to far/pen hits ground (can't move)/hasn't reached target yet/hit target
                                                            (cond ((> (distance aPen.Position this.Position) range) (this.Say "missed!") (goto acquire-target))
                                                                  ((< aPen.Position.Y 0.1) (goto acquire-target))
                                                                  ((> (distance aPen.Position aStump.Position) 1) (goto fire))
                                                                  ((< (distance aPen.Position aStump.Position) 1) (goto hit)))))) 
                                                    (hit (enter
                                                          (set-timeout 0)
                                                          ; tried something to incorporate "health" in enemies with colors, but enemies refused to die for some reason
                                                          ; (cond ((= aStump.Color.R Color.Chartreuse.R) (set! aStump.Color Color.Yellow))
                                                          ;      ((= aStump.Color.R Color.Yellow.R) (set! aStump.Color Color.Red))
                                                          ;     ((= aStump.Color.R Color.Red.R) 
                                                          ; rejoice!
                                                          (this.Say "hit!")
                                                          ; update display 
                                                          (titles.say (String.Format "Gold: {0} / Kills: {1}  Lives: {2}" gold kills lives))
                                                          ; tell enemy to start over (infinite game!)
                                                          (this.aStump.walk-path.SetState "default")
                                                          ; increase gold and kills
                                                          (set! gold (+ 1 gold))
                                                          (set! kills (+ 1 kills)))
                                                         ; after a kill, look for another enemy
                                                         (messages (TimeoutMessage (goto acquire-target))))
                                                    ; unused state
                                                    (end (enter (set-timeout 0))
                                                         (messages (TimeoutMessage (goto end)))))
                                                  )
                                          (set! towerlist (cons ground-plane.MouseProjection towerlist)))
                                         
                                         ; you are too poor!
                                         (else (announcer.say "not enough gold")
                                               ))))))