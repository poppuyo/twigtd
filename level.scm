;; path (start/end spawns)

(new-component Wall @(-100 0 -51) @(-42 0 -51) 1.0 0.2)
(new-component Wall @(-100 0 -49) @(-40 0 -49)  1.0 0.2)

(new-component Wall @(-42 0 -51) @(-42 0 -61) 1.0 0.2)
(new-component Wall @(-40 0 -49) @(-40 0 -59) 1.0 0.2)

(new-component Wall @(-42 0 -61) @(-30 0 -61) 1.0 0.2)
(new-component Wall @(-40 0 -59) @(-32 0 -59) 1.0 0.2)

(new-component Wall @(-30 0 -61) @(-30 0 -31) 1.0 0.2)
(new-component Wall @(-32 0 -59) @(-32 0 -29) 1.0 0.2)

(new-component Wall @(-30 0 -31) @(0 0 -31) 1.0 0.2)
(new-component Wall @(-32 0 -29) @(-2 0 -29) 1.0 0.2)

(new-component Wall @(0 0 -31) @(0 0 -1) 1.0 0.2)
(new-component Wall @(-2 0 -29) @(-2 0 1) 1.0 0.2)

(new-component Wall @(0 0 -1) @(20 0 -1) 1.0 0.2)
(new-component Wall @(-2 0 1) @(18 0 1) 1.0 0.2)

(new-component Wall @(20 0 -1) @(20 0 31) 1.0 0.2)
(new-component Wall @(18 0 1) @(18 0 29) 1.0 0.2)

(new-component Wall @(20 0 31) @(12 0 31) 1.0 0.2)
(new-component Wall @(18 0 29) @(10 0 29) 1.0 0.2)

(new-component Wall @(12 0 31) @(12 0 40.5) 1.0 0.2)
(new-component Wall @(10 0 29) @(10 0 38.5) 1.0 0.2)

(new-component Wall @(12 0 40.5) @(-100 0 40.5) 1.0 0.2)
(new-component Wall @(10 0 38.5) @(-100 0 38.5) 1.0 0.2)

;; Picks a point at random
(define (random-point)
  (let ((p (+ @(-30 0 -10) (MathUtil.NoiseVector 100))))
    (if (< (magnitude p) 400)
	p
	(random-point))))

;; Put a bunch of trees in random locations.
(for-each (lambda (ignore)
	    (new-component Tree (random-point)))
	  '(10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 310 320 330 340 350 360 370 380 390 400 410 420 430 440 450 460 470 480 490 500))

(for-each (lambda (ignore)
	    (new-component Stump (random-point)))
	  '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))