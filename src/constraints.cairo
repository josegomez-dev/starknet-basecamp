#[derive(Drop)]
struct Human {
    health: u32,
    strength: u32,
}

#[derive(Drop)]
struct Orc {
    health: u32,
    strength: u32,
}

trait Action<T> {
    fn new() -> T;
    fn getHealth(self: @T) -> u32;
    fn getStrength(self: @T) -> u32;
    fn is_alive(self: @T) -> bool;
    fn train(ref self: T);
    fn heal(ref self: T);
    fn hurt(ref self: T);
}

impl HumanImpl of Action<Human> {
    fn new() -> Human {
        Human {
            health: 100,
            strength: 20,
        }
    }
    
    fn getHealth(self: @Human) -> u32 {
        *self.health
    }

    fn getStrength(self: @Human) -> u32 {
        *self.strength
    }
    
    fn is_alive(self: @Human) -> bool {
        *self.health > 0
    }

    fn train(ref self: Human) {
        if self.is_alive() {
            self.strength += 5;
        }
    }
    
    fn heal(ref self: Human) {
        if self.is_alive() {
            self.health += 10;
        }
    }

    fn hurt(ref self: Human) {
        if self.health > 10 {
            self.health -= 10;
        } else {
            self.health = 0;
        }
    }    
    
}

impl OrcImpl of Action<Orc> {
    fn new() -> Orc {
        Orc {
            health: 100,
            strength: 20,
        }
    }
    
    fn getHealth(self: @Orc) -> u32 {
        *self.health
    }

    fn getStrength(self: @Orc) -> u32 {
        *self.strength
    }
    
    fn is_alive(self: @Orc) -> bool {
        *self.health > 0
    }

    fn train(ref self: Orc) {
        if self.is_alive() {
            self.strength += 10;
        }
    }
    
    fn heal(ref self: Orc) {
        if self.is_alive() {
            self.health += 5;
        }
    }

    fn hurt(ref self: Orc) {
        if self.health > 10 {
            self.health -= 10;
        } else {
            self.health = 0;
        }
    }    
    
}

#[cfg(test)]
mod tests {
    // use super::Action;
    use super::*;

    fn human_vs_human_fight(ref human_1: Human, ref human_2: Human) -> Result<(), ByteArray> {
        if !human_1.is_alive() || !human_2.is_alive() {
            return Result::Err("One of the humans is not alive");
        }

        if human_1.getStrength() == human_2.getStrength() {
            human_1.hurt();
            human_2.hurt();
        } else if human_1.getStrength() > human_2.getStrength() {
            human_1.hurt();
        } else {
            human_2.hurt();
        }

        Result::Ok(())
    }

    #[test]
    fn test_human_vs_human_fight() {
        let mut jose: Human = HumanImpl::new();
        let mut marvin: Human = HumanImpl::new();
        match human_vs_human_fight(ref jose, ref marvin) {
            Result::Ok(()) => {
                assert(jose.getHealth() == 90, 'Jose should have 90 health');
                assert(marvin.getHealth() == 90, 'Marvin should have 90 health');
                assert(jose.is_alive(), 'Jose should be alive');
                assert(marvin.is_alive(), 'Marvin should be alive');
            },
            Result::Err(_e) => assert!(false),
        }
    }

    // TODO: make this work | generic constraints | new version of compiler that deprecated old syntax 
    // fn fight<T1, T2>(ref opponent_1: T1, ref opponent_2: T2) -> Result<(), ByteArray> {
    //     if !opponent_1.is_alive() || !opponent_2.is_alive() {
    //         return Result::Err("One of the opponents is not alive");
    //     }
        
    //     if opponent_1.getStrength() == opponent_2.getStrength() {
    //         opponent_1.hurt();
    //         opponent_2.hurt();
    //     } else if opponent_1.getStrength() > opponent_2.getStrength() {
    //         opponent_1.hurt();
    //     } else {
    //         opponent_2.hurt();
    //     }

    //     return Result::Ok(());
    // }

    // #[test]
    // fn test_fight() {
    //     let mut jose: Human = HumanImpl::new();
    //     let mut gormarvin: Orc = OrcImpl::new();
        
    //     match fight(ref jose, ref gormarvin) {
    //         Result::Ok(()) => {
    //             assert!(jose.getHealth() == 90);
    //             assert!(gormarvin.getHealth() == 100);
    //             assert!(jose.is_alive());
    //             assert!(gormarvin.is_alive());
    //         },
    //         Result::Err(_e) => assert!(false),
    //     }
    // }
}