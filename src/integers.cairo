fn unsigned_integers() {
    let _a: u8 = 255;
    let _b: u16 = 65535;
    let _c: u32 = 4294967295;
    let _d: u64 = 18446744073709551615;
    let _e: u128 = 340282366920938463463374607431768211455;
    let _f: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;

    let _g: u8 = 255_u8;
    let _h: u16 = 65535_u16;
    let _i: u32 = 4294967295_u32;
    let _j: u64 = 18446744073709551615_u64;
    let _k: u128 = 340282366920938463463374607431768211455_u128;
    let _l: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935_u256;

    let _m: usize = 4294967295;
    let _n: u32 = 4294967295_usize;
}

fn signed_integers() {
    let _a: i8 = -128;
    let _b: i16 = -32768;
    let _c: i32 = -2147483648;
    let _d: i64 = -9223372036854775808;
    let _e: i128 = -170141183460469231731687303715884105728;
    // i256 is not supported yet
    // let f: i256 = -57896044618658097711785492504343953926634992332820282019728792003956564819968;

    let _g: i8 = 127_i8;
    let _h: i16 =  32767_i16;
    let _i: i32 = 2147483647_i32;
    let _j: i64 = 9223372036854775807_i64;
    let _k: i128 = 170141183460469231731687303715884105727_i128;
    // let _l: i256 = -57896044618658097711785492504343953926634992332820282019728792003956564819969_i256;

    // let _m: isize = -4294967296; // isize is not supported yet
    // let _n: i32 = -4294967296_isize;
}

#[cfg(test)]
mod test {    
    use alexandria_math::fast_power::fast_power;
    use alexandria_math::fast_root::fast_sqrt;

    #[test]
    fn test_basic_uint_math() {
       let a: u8 = 3;
       let b: u8 = 5;

        assert!(a + b == 8);
        assert!(b - a == 2);
        assert!(a * b == 15);
        assert!(b / a == 1);
        assert!(b % a == 2);
        assert!(a == 3);
        assert!(b == 5);
    }

    #[test]
    #[should_panic]
    fn test_uint_overflow_protection() {
        let a: u8 = 255;
        let b: u8 = 1;
        a + b;
    }

    #[test]
    #[should_panic]
    fn test_uint_underflow_protection() {
        let a: u8 = 0;
        let b: u8 = 1;
        a - b;
    }

    #[test]
    fn test_basic_int_math() {
       let a: i8 = 3;
       let b: i8 = 5;

        assert!(a + b == 8);
        assert!(a - b == -2);
        assert!(a * b == 15);
        assert!(b / a == 1);
        assert!(b % a == 2);
        assert!(a == 3);
        assert!(b == 5);
    }

    #[test]
    #[should_panic]
    fn test_int_overflow_protection() {
        let a: i8 = 127;
        let b: i8 = 1;
        a + b;
    }

    #[test]
    #[should_panic]
    fn test_int_underflow_protection() {
        let a: i8 = -128;
        let b: i8 = 1;
        a - b;
    }

    #[test]
    fn test_mixing_types_success() {
        let a: u8 = 3;
        let b: i8 = 5;
        assert!(a + b.try_into().unwrap() == 8);
    }

    #[test]
    fn test_mixing_types_failure() {
        let a: u8 = 3;
        let b: i8 = -5;
        assert!(a.try_into().unwrap() + b == -2);
    }

    #[test]
    fn test_advanced_math() {
        let a: u32 = 4;
        assert!(fast_power(a, 2) == 16);
        assert!(fast_sqrt(a.try_into().unwrap(), 1) == 2);
    }

}
