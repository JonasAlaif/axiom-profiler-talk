mod module {
use vstd::prelude::*;
verus! {
    
spec fn f(x: nat, y: nat) -> bool;
spec fn g(x: nat) -> bool;
spec fn h(x:nat, y: nat) -> bool;

proof fn trigger_forever2()
    requires
        forall|x: nat| g(x),
        forall|x: nat, y: nat| h(x, y) == f(x, y),
        forall|x: nat, y: nat| f(x + 1, 2 * y) && f(2 * x, y + x) || f(y, x) ==> #[trigger] f(x, y),
    ensures
        forall|x: nat, y: nat| x > 2318 && y < 100 ==> h(x, y),
{
    assert(g(4));
}

}} // verus!

fn main() {}
