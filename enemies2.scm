(require 'state-machines)

(define-twig-object one Ball @(-50 0 -50) Color.Yellow)
(define-twig-object two Ball @(-60 0 -50) Color.Yellow)
(define-twig-object three Ball @(-70 0 -50) Color.Yellow)
(define-twig-object four Ball @(-80 0 -50) Color.Yellow)
(define-twig-object five Ball @(-90 0 -50) Color.Yellow)
(define-twig-object six Ball @(-100 0 -50) Color.Yellow)
(define-twig-object seven Ball @(-110 0 -50) Color.Yellow)
(define-twig-object eight Ball @(-120 0 -50) Color.Yellow)
(define-twig-object nine Ball @(-130 0 -50) Color.Yellow)
(define-twig-object ten Ball @(-140 0 -50) Color.Yellow)
(define-twig-object eleven Ball @(-150 0 -50) Color.Yellow)
(define-twig-object twelve Ball @(-160 0 -50) Color.Yellow)
(define-twig-object thirteen Ball @(-170 0 -50) Color.Yellow)
(define-twig-object fourteen Ball @(-180 0 -50) Color.Yellow)
(define-twig-object fifteen Ball @(-190 0 -50) Color.Yellow)
(define-twig-object sixteen Ball @(-200 0 -50) Color.Yellow)
(define-twig-object seventeen Ball @(-210 0 -50) Color.Yellow)
(define-twig-object eighteen Ball @(-220 0 -50) Color.Yellow)
(define-twig-object nineteen Ball @(-230 0 -50) Color.Yellow)
(define-twig-object twenty Ball @(-240 0 -50) Color.Yellow)
(define-twig-object twentyone Ball @(-250 0 -50) Color.Yellow)
(define-twig-object twentytwo Ball @(-260 0 -50) Color.Yellow)
(define-twig-object twentythree Ball @(-270 0 -50) Color.Yellow)
(define-twig-object twentyfour Ball @(-280 0 -50) Color.Yellow)
(define-twig-object twentyfive Ball @(-290 0 -50) Color.Yellow)
(define-twig-object twentysix Ball @(-300 0 -50) Color.Yellow)
(define-twig-object twentyseven Ball @(-310 0 -50) Color.Yellow)
(define-twig-object twentyeight Ball @(-320 0 -50) Color.Yellow)
(define-twig-object twentynine Ball @(-330 0 -50) Color.Yellow)
(define-twig-object thirty Ball @(-340 0 -50) Color.Yellow)

(define enemies (list one two three four five six seven eight nine ten eleven twelve thirteen
                      fourteen fifteen sixteen seventeen eighteen nineteen twenty twentyone
                      twentytwo twentythree twentyfour twentyfive twentysix twentyseven
                      twentyeight twentynine thirty))
(for-each (lambda (x) (set! x.Cloaked true) (set! x.color Color.Yellow))
          enemies)

(within enemies
        (define-state-machine walk-path
          (start-point (enter (set-timeout 0)
                              (set! this.Velocity @(5 0 0)))
                       (messages (TimeoutMessage
                                  (cond ((< (distance this.Position @(-40 0 -50)) 1) (goto point2))
                                        ((> (distance this.Position @(-40 0 -50)) 1) (goto start-point))))))
          (point2 (enter (set-timeout 0)
                         (set! this.Velocity @(0 0 -5)))
                  (messages (TimeoutMessage
                             (cond ((< (distance this.Position @(-40 0 -60)) 1) (goto point3))
                                   ((> (distance this.Position @(-40 0 -60)) 1) (goto point2))))))
          (point3 (enter (set-timeout 0)
                         (set! this.Velocity @(5 0 0)))
                  (messages (TimeoutMessage
                             (cond ((< (distance this.Position @(-30 0 -60)) 1) (goto point4))
                                   ((> (distance this.Position @(-30 0 -60)) 1) (goto point3))))))
          (point4 (enter (set-timeout 0)
                         (set! this.Velocity @(0 0 5)))
                  (messages (TimeoutMessage
                             (cond ((< (distance this.Position @(-30 0 -30)) 1) (goto point5))
                                   ((> (distance this.Position @(-30 0 -30)) 1) (goto point4))))))
          (point5 (enter (set-timeout 0)
                         (set! this.Velocity @(5 0 0)))
                  (messages (TimeoutMessage
                             (cond ((< (distance this.Position @(0 0 -30)) 1) (goto point6))
                                   ((> (distance this.Position @(0 0 -30)) 1) (goto point5))))))
          (point6 (enter (set-timeout 0)
                         (set! this.Velocity @(0 0 5)))
                  (messages (TimeoutMessage
                             (cond ((< (distance this.Position @(0 0 0)) 1) (goto point7))
                                   ((> (distance this.Position @(0 0 0)) 1) (goto point6))))))
          (point7 (enter (set-timeout 0)
                         (set! this.Velocity @(5 0 0)))
                  (messages (TimeoutMessage
                             (cond ((< (distance this.Position @(20 0 0)) 1) (goto point8))
                                   ((> (distance this.Position @(20 0 0)) 1) (goto point7))))))
          (point8 (enter (set-timeout 0)
                         (set! this.Velocity @(0 0 5)))
                  (messages (TimeoutMessage
                             (cond ((< (distance this.Position @(20 0 30)) 1) (goto point9))
                                   ((> (distance this.Position @(20 0 30)) 1) (goto point8))))))
          (point9 (enter (set-timeout 0)
                         (set! this.Velocity @(-5 0 0)))
                  (messages (TimeoutMessage
                             (cond ((< (distance this.Position @(10 0 30)) 1) (goto point10))
                                   ((> (distance this.Position @(10 0 30)) 1) (goto point9))))))
          (point10 (enter (set-timeout 0)
                          (set! this.Velocity @(0 0 5)))
                   (messages (TimeoutMessage
                              (cond ((< (distance this.Position @(10 0 40)) 1) (goto point11))
                                    ((> (distance this.Position @(10 0 40)) 1) (goto point10))))))
          (point11 (enter (set-timeout 0)
                          (set! this.Velocity @(-5 0 0)))
                   (messages (TimeoutMessage
                              (cond ((< (distance this.Position @(0 0 40)) 1) (goto point12))
                                    ((> (distance this.Position @(0 0 40)) 1) (goto point11))))))
          (point12 (enter (set-timeout 0)
                          (set! this.Velocity @(-5 0 0)))
                   (messages (TimeoutMessage
                              (goto point12))))
          (default (enter (set! this.Position @(99 0 99))
                          (set-timeout 0))
            (messages (TimeoutMessage
                       (goto default))))
          (default2 (enter (set-timeout 0))
            (messages (TimeoutMessage (this.Say "I'm dead!") (goto default2))))))
;  ;(reset-locomotion)
;  ;; The angle to move along in the ground plane
;  ;; 0=along X axis, not that it really matters
;;  (define-signal walk-angle
;;    (if (in-state? walk-path 'point2 )
;;	0 0))
;  ;; Compute a vector from the angle
;  (define-signal walk-direction
;    this.FacingDirection)
;;(vector (cos walk-angle) 0 (sin walk-angle)))
;  ;; Keep turning the body to face in walk-direction, whether we're
;  ;; walking or not.
;  (define-posture-behavior keyboard-steer-left
;    (let ((error (* 50
;		    (cross this.FacingDirection walk-direction))))
;      (posture-force shoulder-yaw: error.Y
;		     pelvis-yaw: error.Y))
;    activation: 1)
;  ;; Move in the direction of walk-direction when up key pressed
;  (define-locomotion-behavior keybord-drive-forward
;    walk-direction
;    activation: (if (or (in-state? walk-path 'default) (in-state? walk-path 'default2)) 0 10)))