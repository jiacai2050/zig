test "ambiguous precedence" {
    const x: u8 = 1;
    const y: u8 = 2;
    const z: u8 = 3;
    
    // 1. Could be multiplication by a masked value: (x&y) *% z
    // 2. Or masking the result of multiplication:   x & (y*%z)
    _ =  x & y *% z;
}

// obj=ambiguous operator precedence with operators ... & ... *% ...; use parentheses to disambiguate