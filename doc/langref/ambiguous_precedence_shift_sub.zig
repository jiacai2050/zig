test "ambiguous precedence" {
    const x: u64 = 1;
    const y: u6 = 63;
    
    // We probably meant `(x << y) - 1`
    // But thats not how it would have compiled
    _ = x << y - 1;
}

// obj=ambiguous operator precedence with operators … << … - …; use parentheses to disambiguate