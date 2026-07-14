test "ambiguous precedence" {
    const x: u8 = 1;
    const y: u8 = 2;
    const z: u8 = 3;
    
    // Its not obvious below if this is multiplication by a masked value
    // `(x&y) *% z`
    // or a masking of wrapped multiplication
    // `x & (y*%z)`
    _ =  x & y *% z;
}

// obj=ambiguous operator precedence with operators … & … *% …; use parentheses to disambiguate