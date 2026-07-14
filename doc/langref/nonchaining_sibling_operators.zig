fn foo(x: anytype, y: anytype, z: anytype) void {
    _ = x << y << z;
}   

// obj=repetition of non-chainable operators … << … << …; use parentheses to disambiguate