; some z3 options
(set-option :print-success false)
(set-info :smt-lib-version 2.0)
(set-option :auto_config false)
(set-option :smt.mbqi false)
(set-option :smt.QI.EAGER_THRESHOLD 100)
(set-option :smt.refine_inj_axioms false)


(declare-sort Slice) ; &[i32]
(declare-sort Address) ; *const i32
(declare-sort Heap)

; fn slot(slice: &[i32], idx: usize) -> *const i32 {
;     &slice[idx] as *const _
; }
(declare-fun slot (Slice Int) Address)

; fn slot_inverse(slice: &[i32], address: *const i32) -> usize {
;     ...
; }
(declare-fun slot_inverse (Slice Address) Int)

; unsafe fn lookup(address: *const i32) -> i32 {
;     unsafe { *address }
; }
(declare-fun lookup (Heap Address) Int) ; dereference on the heap

; fn next(address: *const i32) -> *const i32 {
;     address.wrapping_offset(1)
; }
(declare-fun next (Address) Address)


(assert (forall
    ((slice Slice) (i Int))
    (!
        ; ∀ slice, i. i == slot_inverse(slice, slot(slice, i))
        (= i (slot_inverse slice (slot slice i)) )

        :pattern ((slot slice i))
        :qid injectivity
    )
))
(assert (forall
    ((slice Slice) (i Int))
    (!
        ; ∀ slice, i. next(slot(slice, i)) == slot(slice, i + 1)
        (= (next (slot slice i)) (slot slice (+ i 1)) )

        :pattern ((next (slot slice i)))
        :qid next_def
    )
))

(declare-const heap Heap)
(declare-const s Slice)
(declare-const idx Int)
(declare-const len Int)

(assert (forall
    ((i Int) (j Int))
    (!
        ; ∀ i, j. 0 <= i && i < j && j < len ==> lookup(heap, slot(s, i)) <= lookup(heap, slot(s, j))
        (or (< i 0) (>= i j) (>= j len) (<= (lookup heap (slot s i)) (lookup heap (slot s j))) )

        :pattern ((lookup heap (slot s i)) (lookup heap (slot s j)))
        :qid sortedness
    )
))

(assert (and (>= idx 0) (< (+ idx 100) len)))
(assert (not (< (lookup heap (slot s idx)) (lookup heap (next (slot s idx))) )))
(check-sat)
