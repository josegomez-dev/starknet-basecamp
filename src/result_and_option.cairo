fn findEven(x: u32) -> Option<u32> {
    if x % 2 == 0 {
        Option::Some(x)
    } else {
        Option::None
    }
}

fn divide(a: u32, b: u32) -> Result<u32, ByteArray> {
    if b == 0 {
        Result::Err("Division by zero")
    } else {
        Result::Ok(a / b)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_divide_by_zero_should_fail() {
        let result: Result<u32, ByteArray> = divide(10, 0);
        assert!(result.is_err());
    }

    #[test]
    fn test_divide_by_non_zero_should_fail_match() {
        let result: Result<u32, ByteArray> = divide(10, 0);
        match result {
            Result::Err(_) => assert!(true),
            Result::Ok(_) => assert!(false),
        }
    }
}