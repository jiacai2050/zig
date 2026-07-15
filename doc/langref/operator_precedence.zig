const assert = @import("std").debug.assert;

test "operator precedence" {
    const x = 1;
    const y = 2;
    const z = 3;

    assert(x + y * z == x + (y*z));
    assert(x * y + z == (x*y) + z);
    
    // Ambiguously related operators may exist in the same expression if they are not adjacent
    assert(x*y + x%y == (x*y) + (x%y));
    // Thus includes comparisons
    assert(x & y != x + y);

    // Or's and and's may be freely chained, but not with each other
    assert(false or x == y or x + y == z);
    assert(true and x != y and y != z);
    // The following line would be a compile error
    // assert(false or x != y and y != z);
}

// test