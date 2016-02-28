(do

  ; load lib
  (eval (parse (loads "lib.lsp") "lib.lsp") global)


  (= eachi (fn (f lst)
    (let (i 0)
      (while lst
        (f (car lst) i)
        (++ i)
        (= lst (cdr lst))))))


  (= print-grid (fn (grid)
    (each (fn (row)
            (print
              (map (fn (x) (if (is x 0) '- '#))
                   row)))
          grid)))


  (= get-cell (fn (grid x y)
    (or (nth x (nth y grid)) 0)))


  (= next-cell (fn (grid cell x y)
    (let (n (+ (get-cell grid (- x 1) (- y 1))
               (get-cell grid (- x 1) y)
               (get-cell grid (- x 1) (+ y 1))
               (get-cell grid x (- y 1))
               (get-cell grid x (+ y 1))
               (get-cell grid (+ x 1) (- y 1))
               (get-cell grid (+ x 1) y)
               (get-cell grid (+ x 1) (+ y 1))))
      (if (and (is cell 1) (or (is n 2) (is n 3))) 1
          (and (is cell 0) (is n 3)) 1
          0))))


  (= next-grid (fn (grid)
    (collect (fn (add-row)
      (eachi (fn (row y)
               (add-row (collect (fn (add-cell)
                 (eachi (fn (cell x)
                          (add-cell (next-cell grid cell x y)))
                        row)))))
             grid)))))


  (= life (fn (grid n)
    (times n (fn (i)
      (print "--- iteration" (+ i 1))
      (print-grid grid)
      (print)
      (= grid (next-grid grid))))))


  ; blinker in a 3x3 universe
  (life '((0 1 0)
          (0 1 0)
          (0 1 0))
        5)

  ; glider in an 8x8 universe
  (life '((0 0 1 0 0 0 0 0)
          (0 0 0 1 0 0 0 0)
          (0 1 1 1 0 0 0 0)
          (0 0 0 0 0 0 0 0)
          (0 0 0 0 0 0 0 0)
          (0 0 0 0 0 0 0 0)
          (0 0 0 0 0 0 0 0)
          (0 0 0 0 0 0 0 0))
        24))
