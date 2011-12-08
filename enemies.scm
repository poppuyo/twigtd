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
                              (set! this.Velocity @(5 0 0))) ; (* (+ 1 (/ kills 5)) @(5 0 0))))
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
          (default (enter (set! this.Velocity @(0 0 0)) 
                          (set! this.Position @(-50 0 -50))
                          (set-timeout 5))
            (messages (TimeoutMessage
                       (cond ((< 0.5 (distance this.Position @(-50 0 -50)))(goto default))
                             (else (goto start-point))))))))
