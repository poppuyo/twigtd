;; (gameCamera.LookAt announcer 10)

(gameCamera.LookAt announcer 10)

(define-state-machine moveCamera
  (idle (enter  (set-timeout 1))
        (messages (TimeoutMessage  (goto idle))
                  (KeyDownMessage Keys.Up (goto moveCameraUp))
                  (KeyDownMessage Keys.Down (goto moveCameraDown))
                  (KeyDownMessage Keys.Left (goto moveCameraLeft))
                  (KeyDownMessage Keys.Right (goto moveCameraRight))))
  (moveCameraUp (enter (set-timeout 0))
                (messages (TimeoutMessage (set! gameCamera.Position.Z (+ gameCamera.Position.Z 1)) (announcer.Say "hi!") (goto idle))))
  (moveCameraDown (enter (set-timeout 0))
                  (messages (TimeoutMessage (set! gameCamera.Position.Z (- gameCamera.Position.Z 1)) (goto idle))))
  (moveCameraLeft (enter (set-timeout 0))
                  (messages (TimeoutMessage (set! gameCamera.Position.X (+ gameCamera.Position.X 1)) (goto idle))))
  (moveCameraRight (enter (set-timeout 0))
                   (messages (TimeoutMessage (set! gameCamera.Position.X (- gameCamera.Position.X 1)) (goto idle)))))