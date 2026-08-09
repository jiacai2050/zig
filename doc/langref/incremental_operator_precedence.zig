const expectEqual = @import("std").testing.expectEqual;
const expect = @import("std").testing.expect;

test "Operator Precedence" {    
    // Arithmetic
    // + and - can be freely mixed and are left associative
    try expectEqual((2 + 3) + 4, 2 + 3 + 4);
    try expectEqual((1 - 2) - 3, 1 - 2 - 3);
    
    // Saturating and wrapping modifications to arithmetic operators act the same
    const x: u8 = 255;
    try expectEqual((x +% 2) -| 3, x +% 2 -| 3);
    try expectEqual(0, x +% 2 -| 3);

    // Since all associative operators are left associative, non-left-to-right evaluation must be forced with parenthesis
    try expectEqual(255, x +% (2 -| 3));

    // * and / can be freely mixed and bind tigher than any addition
    try expectEqual((8 / 2) * 4, 8 / 2 * 4);
    try expectEqual(1 + (2 * 3), 1 + 2 * 3);

    // The Modulus is special in that it cannot be repeated without parenthesis
    // The following line would be a compile error
    // _ = x % 7 % 3;
    // However it does bind tighter than addition
    try expectEqual(1 + (x % 3), 1 + x % 3);

    // Bitwise Operators
    // &, |, and ^ can all be freely repeated, but not mixed without parenthesis
    try expectEqual((x & 0xF) & 1, x & 0xF & 1);
    try expectEqual((x | 0xF) | 1, x | 0xF | 1);
    try expectEqual((x ^ 0xF) ^ 1, x ^ 0xF ^ 1);
    // The following line would be a compile error
    // _ = x & 0xF | 0xF0;

    // Bitshifts <<, <<|, and >> cannot be repeated without parenthesis nor mixed with other bitwise operators
    // The following lines would be compile errors
    // _ = x >> 1 >> 2;
    // _ = 1 << 16 | 1 << 8 | 1;
    // Instead parentheses should be used
    try expectEqual(63, (x >> 1) >> 2);
    try expectEqual(0x10101, (1 << 16) | (1 << 8) | 1);

    // Comparisons
    // < > <= >= == != cannot be chained
    // Binds lower than either bitwise operators or arithmetic operators
    //   which allows one on one side and one on the other
    try expect(1 | 4 <= 1 + 4);
    // equivilent to this code
    try expect((1 | 4) <= (1 + 4));

    // Boolean Operators
    // `and` and `or` can be freely chained with themselves, shortcircuiting left to right
    // they may not be mixed with each other without parenthesis
    // bind looser than comparisons
    const false_expr: bool = 7 < 2;
    const true_expr: bool = 1 + 1 == 2;

    try expect(false_expr or false_expr or true_expr);
    try expect(7 < 2 or 7 < 2 or 1 + 1 == 2);
    try expect(((7 < 2) or (7 < 2)) or (1 + 1 == 2));

    try expect(true_expr and true_expr and true_expr);
    try expect(1 + 1 == 2 and 1 + 1 == 2 and 1 + 1 == 2);
    try expect(((1 + 1 == 2) and (1 + 1 == 2)) and (1 + 1 == 2));

    // The following line would be a compile error
    // _ = false_expr or true_expr and true_expr
    // Instead parentheses should be used
    try expect(false_expr or (true_expr and true_expr));

    // Orelse and Catch
    // Like Boolean Operators, may be chained with themselves, but not each other
    // bind looser than prefix expressions
    const some_null: ?u8 = null;
    try expectEqual(2, some_null orelse some_null orelse 2);

    const some_error: error{invalid}!u8 = error.invalid;
    try expectEqual(3, some_error catch some_error catch 3);

    // The following line would be a compile error
    // _ = some_error catch some_null orelse 1;
    // Instead parentheses should be used
    try expectEqual(1, (some_error catch some_null) orelse 1);
}

// obj