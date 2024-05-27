// Functions

fn slot(slice: &[i32], idx: usize) -> *const i32 {
    &slice[idx] as *const _
}

unsafe fn lookup(address: *const i32) -> i32 {
    unsafe { *address }
}

fn next(address: *const i32) -> *const i32 {
    address.wrapping_offset(1)
}

// Axioms (quantifiers)

axiom slot_injective() {
    forall(|slice: &[i32], i: usize, j: usize|
        i != j ==> slot(slice, i) != slot(slice, j)
    )
}

axiom next_definition() {
    forall(|slice: &[i32], i: usize|
        next(#[trigger] slot(slice, i)) == slot(slice, i + 1)
    )
}

// To verify

fn foo(s: &[i32], idx: usize, len: usize) {
    // Assume slice is sorted
    assume(forall(|i: usize|
        0 <= i && i < len ==> #[trigger] lookup(slot(s, i)) <= lookup(next(slot(s, i)))
    ))

    // Assume slice isn't trivial len
    assume(
        0 <= idx && idx + 100 < len
    )

    // Assert that the next array entry must be strictly larger
    assert(
        lookup(slot(s, idx)) < lookup(next(slot(s, idx)))
    )
}
