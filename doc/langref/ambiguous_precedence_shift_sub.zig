test "ambiguous precedence" {
    const x: u64 = 1;
    const y: u6 = 63;
    
    // 1. Could mean shift then subtract: (x<<y) - 1 such as to generate a mask
    // 2. Or to shift after the subtract: x << (y-1) such as selecting bits
    _ = x << y - 1;
}

// obj=ambiguous operator precedence with operators ... << ... - ...; use parentheses to disambiguate