#[cfg(test)]
mod tests {
    
    mod simple_enum {

        #[derive(PartialEq, Drop)]
        enum Error {
            DivideByZero,
            DividendSamllerThanDivisor,
            InexactDivision,
        }

        fn divide(dividend: u32, divisor: u32) -> Result<u32, Error> {
            if divisor == 0 {
                return Result::Err(Error::DivideByZero);
            }
            if dividend < divisor {
                return Result::Err(Error::DividendSamllerThanDivisor);
            }
            if dividend % divisor != 0 {
                return Result::Err(Error::InexactDivision);
            }
            Result::Ok(dividend / divisor)
        }

        #[test]
        fn test_simple_enum() {
            let result = divide(10, 2);
            assert!(result == Result::Ok(5));
        }
    }

    mod complex_enums {

        #[derive(PartialEq, Drop)]
        enum Error {
            DivideByZero,
            DividendSamllerThanDivisor: Division,
            InexactDivision: Reminder,
        }

        #[derive(PartialEq, Drop)]
        struct Division {
            dividend: u32,
            divisor: u32,
        }

        type Reminder = u32;

        fn divide(dividend: u32, divisor: u32) -> Result<u32, Error> {
            if divisor == 0 {
                return Err(Error::DivideByZero);
            }
            if divisor > dividend {
                let division = Division {
                    dividend: dividend,
                    divisor: divisor,
                };
                return Err(Error::DividendSamllerThanDivisor(division));
            }
            if dividend % divisor != 0 {
                let reminder: Reminder = dividend % divisor;
                return Err(Error::InexactDivision(reminder));
            }
            return Result::Ok(dividend / divisor);
        }

        #[test]
        fn test_complex_enum() {
            let result = divide(10, 2);
            assert!(result == Result::Ok(5));

            let result = divide(10, 0);
            assert!(result == Result::Err(Error::DivideByZero));

            let result = divide(10, 3);
            assert!(result == Result::Err(Error::InexactDivision(1)));

            let result = divide(4, 10);
            assert!(result == Result::Err(Error::DividendSamllerThanDivisor(
                Division { 
                    dividend: 4, 
                    divisor: 10 
                }))
            );

            let result = divide(10, 10);
            assert!(result == Result::Ok(1));

        }
    }
}