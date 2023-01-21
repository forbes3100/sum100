
all: sum100s sum100c sum100r

sum100s: sum100s.swift
	swiftc -O sum100s.swift

sum100c: sum100c.cpp
	gcc -O2 sum100c.cpp -std=c++11 -lstdc++ -o sum100c

sum100r: sum100r.rs
	rustc -O sum100r.rs
