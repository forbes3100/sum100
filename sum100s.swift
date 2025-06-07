//
//  sum100s.swift
//
//  Created by Scott Forbes on 11/27/22.
//
// Solution to Problem 8 in Mathematical Games, Scientific American, Oct. 1962:
// "the problem of inserting mathematical signs wherever one likes between the digits
// 1, 2, 3, 4, 5, 6, 7, 8, 9 to make the expression equal 100". And also the problem
// with the digits in reverse.
//
// The output matches that given by Mark Resnick in his letter to the editor, Jan. 1963,
// of his program which "was solved on a Philco 211 computer at Willow Grove, Pa.,
// in 48 seconds." That Philco 211, aka TRANSAC S-1000, was the "world's first
// transistorized high speed computer", "which began life in 1955 as an NSA project
// called SOLO to build a transistorized version of the UNIVAC 1103".
//
// Running it 100000 times on a Mac M1 takes 13.43s, and on 4 cores at once
// takes 14.37s, or 1.3 million times faster than the Philco.

import Foundation

func solveSum(_ target: Int, ascending: Bool) {
    
    enum Symbol: Int {
        case plus = 0
        case minus
        case none
    }

    struct Solution {
        var symbols: [Int]
        var nSigns: Int
    }

    var solutions = [Solution]()
    var symbols = [Int](repeating: 0, count: 8)
    let nCases = 3*3*3*3*3*3*3*3
    //print("nCases=\(nCases)")
    for _ in 0..<nCases {
        var sum = 0
        var digits = ascending ? 1 : 9
        var prevSymbol = 0 // initialized to '+' for implied symbol left of first digit
        for i in 0..<8 {
            let digit = ascending ? i + 2 : 8 - i
            let symbol = symbols[i]
            if symbol == Symbol.none.rawValue {
                // no symbol: just shift and accumulate digit
                digits = 10*digits + digit
            } else {
                // symbol: apply previous symbol, then save current one
                if (prevSymbol == Symbol.plus.rawValue) {
                    sum += digits
                } else {
                    sum -= digits
                }
                prevSymbol = symbol
                digits = digit
            }
        }

        // apply final operation
        if (prevSymbol == Symbol.plus.rawValue) {
            sum += digits
        } else {
            sum -= digits
        }

        // keep solutions that match
        if sum == target {
            var nSigns = 0
            for i in 0...7 {
                let symbol = symbols[i]
                if symbol == Symbol.plus.rawValue {
                    nSigns += 1
                } else if symbol == Symbol.minus.rawValue {
                    nSigns += 1
                }
            }
            solutions.append(Solution(symbols: symbols, nSigns: nSigns))
        }

        // increment symbols array, with carry
        for i in (0..<8).reversed() {
            symbols[i] += 1
            if symbols[i] == 3 {
                symbols[i] = 0
            } else {
                break
            }
        }
    }
    
    print("\nSOLUTIONS FOR \(ascending ? "A" : "DE")SCENDING SEQUENCE\n\n")
    print("                                    NUMBER OF")
    print("                                  PLUS OR MINUS")
    print("      SOLUTION                        SIGNS\n")

    let sortedSolutions = solutions.sorted {
        $1.nSigns > $0.nSigns
    }

    for solution in sortedSolutions {
        var s = ""
        symbols = solution.symbols
        for i in 0...7 {
            s.append(String(ascending ? i+1 : 9-i))
            let symbol = symbols[i]
            if symbol == Symbol.plus.rawValue {
                s.append("+")
            } else if symbol == Symbol.minus.rawValue {
                s.append("-")
            }
        }
        s.append(ascending ? "9" : "1")
        s = s.padding(toLength: 16, withPad: " ", startingAt: 0)
        print("\(s)=\(target)                    \(solution.nSigns)")
    }
}

let n = CommandLine.arguments.count == 2 ?
            Int(CommandLine.arguments[1]) ?? 1 : 1

for _ in 0..<n {
    solveSum(100, ascending: true)
    solveSum(100, ascending: false)
}
