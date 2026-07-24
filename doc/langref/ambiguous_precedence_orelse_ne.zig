fn makeBool(x: u32) ?bool {
    if (x == 0) return false;
    if (x == 1) return true;
    return null;
}

test "ambiguous precedence" {
    const x: ?u32 = 0;
    const y: u8 = 0;
    const z: u8 = 0;
    
    // Without parentheses the compiler cannot distinguish between two conflicting interpretations:
    // 1. Compare on the value which may be recovered: (makeBool(x) orelse y) != z
    // 2. Recover to the result of the comparison:     makeBool(x) orelse (y != z)
    _ = makeBool(x) orelse y != z;
}

// obj=ambiguous operator precedence with operators ... orelse ... != ...; use parentheses to disambiguate