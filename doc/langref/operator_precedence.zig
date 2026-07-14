const assert = @import("std").debug.assert;

test "operator precedence" {
    const x = 1;
    const y = 2;
    const z = 3;

    // Because comparisons have a lower precedence than any arithmetic
    // We can safely avoid parenthesizing the expressions
    assert(x + y * z == x + (y*z));
    assert(x * y + z == (x*y) + z);
    
    // We can also use ambiguous operators as long as they are seperated
    // by a well ordered one such as below
    assert(x*y + x%y == (x*y) + (x%y));
    //That includes comparisons
    assert(x & y != x + y);

    // We can freely chain or's and and's, but not with each other
    assert(false or x == y or x + y == z);
    assert(true and x != y and y != z);
}

// test