//
//  sum100c.cpp
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
// C++11 version (translated from swift by ChatGPT; 20% faster but unsafe)

#include <iostream>
#include <vector>

enum Symbol {plus, minus, none};

struct Solution {
    std::vector<int> symbols;
    int nSigns;
};

void solveSum(int target, bool ascending) {
    std::vector<Solution> solutions;
    std::vector<int> symbols(8, 0);
    int nCases = 3*3*3*3*3*3*3*3;

    for (int i = 0; i < nCases; i++) {
        int sum = 0;
        int digits = ascending ? 1 : 9;
         // initialized to '+' for implied symbol left of first digit
        int prevSymbol = 0;
        for (int i = 0; i < 8; i++) {
            int digit = ascending ? i + 2 : 8 - i;
            int symbol = symbols[i];
            if (symbol == none) {
                // no symbol: just shift and accumulate digit
                digits = 10*digits + digit;
            } else {
                // symbol: apply previous symbol, then save current one
                if (prevSymbol == plus) {
                    sum += digits;
                } else {
                    sum -= digits;
                }
                prevSymbol = symbol;
                digits = digit;
            }
        }

        // apply final operation
        if (prevSymbol == plus) {
            sum += digits;
        } else {
            sum -= digits;
        }

        // keep solutions that match
        if (sum == target) {
            int nSigns = 0;
            for (int i = 0; i < 8; i++) {
                int symbol = symbols[i];
                if (symbol == plus) {
                    nSigns += 1;
                } else if (symbol == minus) {
                    nSigns += 1;
                }
            }
            solutions.push_back(Solution{symbols, nSigns});
        }

        // increment symbols array, with carry
        for (int i = 7; i >= 0; --i) {
            symbols[i] += 1;
            if (symbols[i] == 3) {
                symbols[i] = 0;
            } else {
                break;
            }
        }
    }
    std::cout << "\nSOLUTIONS FOR " << (ascending ? "A" : "DE") << "SCENDING SEQUENCE\n\n\n";
    std::cout << "                                    NUMBER OF" << std::endl;
    std::cout << "                                  PLUS OR MINUS" << std::endl;
    std::cout << "      SOLUTION                        SIGNS\n\n";

    std::sort(solutions.begin(), solutions.end(), [](Solution a, Solution b) {
        return b.nSigns > a.nSigns;
    });

    for (auto solution : solutions) {
        std::string s = "";
        symbols = solution.symbols;
        for (int i = 0; i < 8; i++) {
            s.append(std::to_string(ascending ? i+1 : 9-i));
            int symbol = symbols[i];
            if (symbol == plus) {
                s.append("+");
            } else if (symbol == minus) {
                s.append("-");
            }
        }
        s.append(ascending ? "9" : "1");
        s = s + std::string(16-s.length(), ' ');
        std::cout << s << "=" << target << "                    " << solution.nSigns << std::endl;
    }
}

int main(int argc, const char* argv[])
{
  int n = argc == 2 ? atoi(argv[1]) : 1;
  
  for (int i = 0; i < n; i++)
  {
    solveSum(100, true);
    solveSum(100, false);
  }

  return 0;
}
