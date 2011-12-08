(set! game.CameraTargetLocation announcer.Position)
(set! game.CameraPosition @(-35 5 -25))

(define-state-machine dialog
  (welcome1 (enter (this.Say "Welcome to twigtd!") 
                   (set-timeout 2))
            (messages (TimeoutMessage (goto welcome2))))
  (welcome2 (enter (this.Say "twigtd is a tower defense game implemented in twig by...") (set-timeout 3))
            (messages (TimeoutMessage 
                       (goto names))))
  (names (enter (this.Say "uhm... what were their names again?") (set! this.FacingDirection @(-100 0 0))
                (set-timeout 2))
         (messages (TimeoutMessage (goto names2))))
  (names2 (enter (this.Say "ah yes...") (set! this.FacingDirection @(0 0 10)) (set-timeout 2))
          (messages (TimeoutMessage (this.Say "by jason, john, and josiah!") 
                                    (goto welcome3))))
  (welcome3 (enter (set-timeout 2))
            (messages (TimeoutMessage (this.Say "I am the announcer. I will be your guide and tip-giver.")
                                      (goto welcome4))))
  (welcome4 (enter (set-timeout 3))
            (messages (TimeoutMessage (this.Say "You may skip my tutorial by pressing the Space key.")
                                      (goto welcome5))))
  (welcome5 (enter (set-timeout 2))
            (messages (TimeoutMessage (this.Say "Now without further ado, I'll explain tower defense.")
                                      (goto welcome6))))
  (welcome6 (enter (set-timeout 4))
            (messages (TimeoutMessage (this.Say "Tower defense is a type of game where you place towers along a path.")
                                      (goto welcome7))))
  (welcome7 (enter (set-timeout 4))
            (messages (TimeoutMessage (this.Say "Enemies will advance down this path, and should be destroyed, unless you wish to lose.")
                                      (goto welcome8))))
  (welcome8 (enter (set-timeout 4))
            (messages (TimeoutMessage (this.Say "This game will scale the difficulty as you get more and more kills.")
                                      (goto welcome9))))
  (welcome9 (enter (set-timeout 3))
            (messages (TimeoutMessage (this.Say "Have I mentioned that this is a (potentially) endless game? Enemies will keep respawning!")
                                      (goto welcome10))))
  (welcome10 (enter (set-timeout 4))
            (messages (TimeoutMessage (this.Say "You can place towers with the left-mouse button. They will cost you 25 gold.")
                                      (goto welcome11))))
  (welcome11 (enter (set-timeout 4))
            (messages (TimeoutMessage (this.Say "You can upgrade towers with the right-mouse button. It will cost you 50 gold, then 100 gold.")
                                      (goto welcome12))))
  (welcome12 (enter (set-timeout 2))
            (messages (TimeoutMessage (this.Say "You can get more gold by killing enemies.")
                                      (goto welcome13))))
  (welcome13 (enter (set-timeout 4))
            (messages (TimeoutMessage (this.Say "You'll be able to move your camera with the arrow keys, and zoom in/out with x/z.")
                                      (goto welcome14))))
  (welcome14 (enter (set-timeout 2))
            (messages (TimeoutMessage (this.Say "A word of warning: towers can't be sold, so place them wisely!")
                                      (goto welcome15))))
  (welcome15 (enter (set-timeout 2))
            (messages (TimeoutMessage (this.Say "That's it! Press Space to begin!")
                                      (goto welcome15))))

  (done (enter (set! this.FacingDirection @(0 0 10)) 
               (set-timeout 1))
        (messages (TimeoutMessage (goto done))))
  (really-done (enter (set-timeout 1000000))
               (messages (TimeoutMessage (goto really-done)))))
