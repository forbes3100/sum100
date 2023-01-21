//
//  sum100r.rust
//
// Solution to Problem 8 in Mathematical Games, Scientific American, Oct. 1962:
// "the problem of inserting mathematical signs wherever one likes between the digits
// 1, 2, 3, 4, 5, 6, 7, 8, 9 to make the ex­pression equal 100". And also the problem
// with the digits in reverse.
//
// The output matches that given by Mark Resnick in his letter to the editor, Jan. 1963,
// of his program which "was solved on a Philco 211 computer at Willow Grove, Pa.,
// in 48 seconds." That Philco 211, aka TRANSAC S-1000, was the "world's first
// transistorized high speed computer", "which began life in 1955 as an NSA project
// called SOLO to build a transistorized version of the UNIVAC 1103".
//
// Rust version (translated from C++11 by ChatGPT)
//
// Mac M1 running 100000 loops on each of 4 cores takes 11.1s, which is
// 1.7 million times faster than the Philco.

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n: usize = if args.len() == 2 {
        args[1].parse().unwrap()
    } else {
        1
    };

    for _ in 0..n {
        solve_sum(100, true);
        solve_sum(100, false);
    }
}

fn solve_sum(target: i32, ascending: bool) {
    let mut solutions = Vec::new();
    let mut symbols = vec![0; 8];
    let n_cases = 3 * 3 * 3 * 3 * 3 * 3 * 3 * 3;
    
    for _ in 0..n_cases {
        let mut sum: i32 = 0;
        let mut digits = if ascending { 1 } else { 9 };
        // initialized to '+' for implied symbol left of first digit
        let mut prev_symbol = 0;
        for i in 0..8 {
            let digit = if ascending { i + 2 } else { 8 - i };
            let symbol = symbols[i];
            if symbol == Symbol::None as i32 {
                // no symbol: just shift and accumulate digit
                digits = 10 * digits + digit;
            } else {
                // symbol: apply previous symbol, then save current one
                if prev_symbol == 0 {
                    sum += digits as i32;
                } else {
                    sum -= digits as i32;
                }
                prev_symbol = symbol;
                digits = digit;
            }
        }
    
        // apply final operation
        if prev_symbol == 0 {
            sum += digits as i32;
        } else {
            sum -= digits as i32;
        }

        // keep solutions that match
        if sum == target {
            let mut n_signs = 0;
            for i in 0..8 {
                let symbol = symbols[i];
                if symbol == Symbol::Plus as i32 || symbol == Symbol::Minus as i32 {
                    n_signs += 1;
                }
            }
            solutions.push(Solution{symbols: symbols.clone(), n_signs});
        }

        // increment symbols array, with carry
        for i in (0..8).rev() {
            symbols[i] += 1;
            if symbols[i] == 3 {
                symbols[i] = 0;
            } else {
                break;
            }
        }
    }

    println!("\nSOLUTIONS FOR {}SCENDING SEQUENCE\n\n", if ascending { "A" } else { "DE" });
    println!("                                    NUMBER OF");
    println!("                                  PLUS OR MINUS");
    println!("      SOLUTION                        SIGNS\n");

    solutions.sort_by(|a, b| a.n_signs.cmp(&b.n_signs));
    for solution in solutions {
        let mut s = String::new();
        symbols = solution.symbols;
        for i in 0..8 {
            s.push_str(&(if ascending { i+1 } else { 9-i }).to_string());
            let symbol = symbols[i];
            if symbol == Symbol::Plus as i32 {
                s.push('+');
            } else if symbol == Symbol::Minus as i32 {
                s.push('-');
            }
        }
        s.push_str(if ascending { "9" } else { "1" });
        s.push_str(&std::iter::repeat(" ").take(16 - s.len()).collect::<String>());
        println!("{}={}                    {}", s, target, solution.n_signs);
    }
}

enum Symbol {
    Minus,
    Plus,
    None,
}

struct Solution {
    symbols: Vec<i32>,
    n_signs: i32,
}