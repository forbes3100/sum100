# sum100
Sum digits to 100 -- 1962 SciAm Mathematical Games solver recreation

Solution to Problem 8 in Mathematical Games, Scientific American, Oct. 1962:
"the problem of inserting mathematical signs wherever one likes between the digits
1, 2, 3, 4, 5, 6, 7, 8, 9 to make the ex­pression equal 100". And also the problem
with the digits in reverse.

The output matches that given by Mark Resnick in his letter to the editor, Jan. 1963,
of his program which "was solved on a Philco 211 computer at Willow Grove, Pa.,
in 48 seconds." That Philco 211, aka TRANSAC S-1000, was the "world's first
transistorized high speed computer", "which began life in 1955 as an NSA project
called SOLO to build a transistorized version of the UNIVAC 1103".

## Getting Started

To install, first clone the repository:

```
git clone https://github.com/forbes3100/sum100.git
cd sum100
```

Then build all 3 versions:

```
make
```

## Usage

```
./sum100c
```

Will write the C++ version's results to standard out. sum100s and sum100r are
the Swift and Rust versions, respectively. Their output differs slightly due
to different sort ordering of equal values.

To run it 100000 times:

```
./sum100c 100000 >/dev/null
```
