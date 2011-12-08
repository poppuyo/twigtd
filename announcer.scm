(define-state-machine Game
  (welcome (enter (set-timeout 2))
    (messages (TimeoutMessage (this.Say "Welcome to Twig Tower Defense!")
    	(goto welcome))))
  (levelDesign)
  (play)
  (win)
  (lose))