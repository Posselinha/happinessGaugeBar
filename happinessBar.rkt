(define (gauge-prog gauge)
  (number->string-digits gauge 2))
(define SCENE-WIDTH 500)
(define SCENE-HEIGHT 200)
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))
(define (gauge-text gauge-number)
  (string-append "Happiness Gauge: " (gauge-prog gauge-number)))

(define (gauge-func gauge)
  (text (gauge-text gauge) 24 "black"))

(define DEFAULT-VALUE 100)

(define GAUGE-WIDTH
  (image-width (gauge-func DEFAULT-VALUE)))

(define GAUGE-HEIGHT
  (image-height (gauge-func DEFAULT-VALUE)))

(define GAUGE-X
  (/ SCENE-WIDTH 2))

(define GAUGE-Y
  (/ SCENE-HEIGHT 2))

(define (bar-level x)
  (if
   (and (>= x 0) (<= x 100))
   x
   (cond
     ([>= x 100] 100)
     ([<= x 0] 0))))

(define (gauge-in-scene number)
  (place-image (gauge-func number) GAUGE-X GAUGE-Y
               (put-image (rectangle (* (/ (bar-level number) 100) SCENE-WIDTH) SCENE-HEIGHT "solid" "red") (* (/ number 100) GAUGE-X) GAUGE-Y SCENE)))

(define (tock y)
  (if
   (and (>= y 0) (<= y 100))
   (- y 0.1)
   (cond
     ([>= y 100] 100)
     ([<= y 0] 0))))

(define (stop y)
  (<= y 0))

(define (press-key y ke)
  (cond
    [(key=? ke "down") (- y (/ y 5))]
    [(key=? ke "up") (+ y (/ y 3))])) 

(define (main number)
  (big-bang number
    [to-draw gauge-in-scene]
    [on-tick tock]
    [on-key press-key]
    [stop-when stop]))

(main 100)
