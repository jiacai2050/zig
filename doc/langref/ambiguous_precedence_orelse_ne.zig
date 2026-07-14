fn makeBool(x: u32) ?bool {
    if (x == 0) return false;
    if (x == 1) return true;
    return null;
}

test "ambiguous precedence" {
    const x: ?u32 = 0;
    const y: u8 = 0;
    const z: u8 = 0;
    
    // We might expect the line below to parse something like:
    //   `makeBool(x) orelse (y != z)`
    // but we might elsewhere want something like 
    //   `(nullable(x) orelse y) != w`
    // to perform a fallback and then a check, either way its 
    // not obvious the behavior so we get an error
    _ = makeBool(x) orelse y != z;
}

// obj=ambiguous operator precedence with operators … orelse … != …; use parentheses to disambiguate