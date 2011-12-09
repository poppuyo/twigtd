; set up camera positioning
(set! gameCamera.SubjectDistance 10)
(set! game.CameraUp @(0 0 -1))
(set! game.CameraPosition @(-40 30 -50))
(set! game.CameraTargetLocation @(-40 0 -50))

; camera mover state-machine
(define-state-machine moveCamera
  (start (when (key-down? Keys.Up)
           ; move in -z
	   (set! game.CameraPosition (+ game.CameraPosition (vector 0 0 -1)))
	   (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 0 0 -1))))
	 (when (key-down? Keys.Down)
           ; move in +z
	   (set! game.CameraPosition (+ game.CameraPosition (vector 0 0 1)))
	   (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 0 0 1))))
	 (when (key-down? Keys.Left)
           ; move in -x
	   (set! game.CameraPosition (+ game.CameraPosition (vector -1 0 0)))
	   (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector -1 0 0))))
	 (when (key-down? Keys.Right)
           ; move in +x
	   (set! game.CameraPosition (+ game.CameraPosition (vector 1 0 0)))
	   (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 1 0 0))))
	 (when (key-down? Keys.Z)
           ; zoom in
	   (set! game.CameraPosition (+ game.CameraPosition (vector 0 1 0)))
	   (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 0 1 0))))
	 (when (key-down? Keys.X)
           ; zoom out
	   (set! game.CameraPosition (+ game.CameraPosition (vector 0 -1 0)))
	   (set! game.CameraTargetLocation (+ game.CameraTargetLocation (vector 0 -1 0))))
	 (when (key-down? Keys.R)
           ; reset camera
           ; does NOT work if the camera is locked onto a character (tab button)
           ; as it will just revert to focusing on the character
	   (set! game.DebugObject null)
	   (set! gameCamera.Subject null)
	   (set! gameCamera.SubjectDistance 10)
	   (set! game.CameraUp @(0 0 -1))
	   (set! game.CameraPosition @(-40 30 -50))
	   (set! game.CameraTargetLocation @(-40 0 -50)))))