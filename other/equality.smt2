; (set-option :smt.mbqi false)
; (set-option :auto_config false)

(declare-sort Vec)
(declare-const empty Vec)

(declare-fun truncate_by (Vec Int) Vec)
(declare-fun pop (Vec) Vec)

(assert (= (truncate_by empty 1) empty))
(assert (= (pop empty) empty))
;(assert (= (pop (truncate_by empty 0)) (truncate_by empty 0)))

(assert (forall ((x Vec) (y Int))
   (! (= (pop (truncate_by x y)) (truncate_by x (+ y 1)))
       :pattern ((pop (truncate_by x y)))
       :qid simplify_pop
   )))

(check-sat)

; truncate_by(a, b) = pop(truncate_by(a, b))

; { pop(truncate_by(x, y)) } -> pop(truncate_by(x, y)) = truncate_by(x, y + 1)
; x -> a, y -> b: pop(truncate_by(a, b)) = truncate_by(a, b + 1)
; truncate_by(a, b) = pop(truncate_by(a, b)) = truncate_by(a, b + 1)
; 
