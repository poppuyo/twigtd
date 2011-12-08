;;(gameCamera.LookAt announcer 10)
;(set! gameCamera.CameraAngle @(0 1 0))
;;(set! gameCamera.Height CameraHeight.BirdsEye)
;(set! gameCamera.Subject announcer)
;(set! gameCamera.SubjectDistance 10)
(set! game.CameraUp @(0 0 -1))
(set! game.CameraPosition (+ game.CameraPosition (vector 0 20 0)))
;(define x 0)
;(define y 0)
;(define z 0)

;(define-macro (define-game-property-controller name stuff ...)
;  `(this.InstallSubcomponent
;    (new-property-controller ,name.Name
;                             game
;                             ,name.Name
;                             (signal-expression (behavior ,name ,@stuff)))))
;
;(define-game-property-controller CameraPosition
;  (vector (+ 0 x) (+ 10 y) (+ 0 z))
;  activation: 1)
;
;(define-game-property-controller CameraTargetLocation
;  (+ game.CameraPosition @(0 0 -1))
;  activation: 1)
                
                ;(set! gameCamera.Height CameraHeight.BirdsEye)
                
                (define-state-machine moveCamera
                  (start (when (key-down? Keys.Up) (set! game.CameraPosition (+ game.CameraPosition (vector 0 0 -1))) (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 0 0 -1))))
                         (when (key-down? Keys.Down) (set! game.CameraPosition (+ game.CameraPosition (vector 0 0 1))) (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 0 0 1))))
                         (when (key-down? Keys.Left) (set! game.CameraPosition (+ game.CameraPosition (vector -1 0 0))) (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector -1 0 0))))
                         (when (key-down? Keys.Right) (set! game.CameraPosition (+ game.CameraPosition (vector 1 0 0))) (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 1 0 0))))
                         (when (key-down? Keys.Z) (set! game.CameraPosition (+ game.CameraPosition (vector 0 1 0))) (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 0 1 0))))
                         (when (key-down? Keys.X) (set! game.CameraPosition (+ game.CameraPosition (vector 0 -1 0))) (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 0 -1 0))))))
                ;((key-down? Keys.Down) (set! gameCamera.Position.Z (- gameCamera.Position.Z 1)))
                ;((key-down? Keys.Left) (set! gameCamera.Position.x (+ gameCamera.Position.x 1)))
                ;((key-down? Keys.Right) (set! gameCamera.Position.x (- gameCamera.Position.x 1)))
                ;(else '()))))
                
                ;(gameCamera.LookAt announcer 10)
                
                ;(define-state-machine moveCamera
                ;  (idle (enter  (set-timeout 1))
                ;        (messages (TimeoutMessage  (goto idle))
                ;                  (KeyDownMessage Keys.Up (goto moveCameraUp))
                ;                  (KeyDownMessage Keys.Down (goto moveCameraDown))
                ;                  (KeyDownMessage Keys.Left (goto moveCameraLeft))
                ;                  (KeyDownMessage Keys.Right (goto moveCameraRight))))
                ;  (moveCameraUp (enter (set-timeout 0))
                ;                (messages (TimeoutMessage (set! gameCamera.Position.Z (+ gameCamera.Position.Z 1)) (announcer.Say "hi!") (goto ;idle))))
                ;  (moveCameraDown (enter (set-timeout 0))
                ;                  (messages (TimeoutMessage (set! gameCamera.Position.Z (- gameCamera.Position.Z 1)) (goto idle))))
                ;  (moveCameraLeft (enter (set-timeout 0))
                ;                  (messages (TimeoutMessage (set! gameCamera.Position.X (+ gameCamera.Position.X 1)) (goto idle))))
                ;  (moveCameraRight (enter (set-timeout 0))
                ;                   (messages (TimeoutMessage (set! gameCamera.Position.X (- gameCamera.Position.X 1)) (goto idle)))))
                