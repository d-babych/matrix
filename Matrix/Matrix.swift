//
//  Matrix.swift
//  Matrix
//
//  Created by Dmytro Babych on 5/25/17.
//  Copyright © 2017 Babych Studio. All rights reserved.
//

import Foundation

precedencegroup PowerPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: left
}

infix operator ^^: PowerPrecedence

struct Matrix<T> : CustomStringConvertible {
    
    typealias T = Decimal
    
    var rows : Int
    var cols : Int
    
    var items : Array<T>
    
    var description : String {
        var str = "Matrix: [ "
        for r in 0 ..< self.rows {
            if r != 0 {
                str += "\n          "
            }
            for c in 0 ..< self.cols {
                str += "\(self[r, c]) "
            }
        }
        str += "]"
        return str
    }
    
    
    init(rows: Int, cols: Int, items: Array<T>) {
        self.rows = rows
        self.cols = cols
        self.items = items
    }
    
    init(rows: Int, cols: Int) {
        let items = Array<T>(repeating: 0, count: rows * cols)
        self.init(rows: rows, cols: cols, items: items)
    }
    
    
    subscript(row: Int, col: Int) -> T {
        get {
            assert(row < self.rows && col < self.cols, "Index out of range")
            let index = self.cols * row + col
            return self.items[index]
        }
        set (newItem) {
            assert(row < self.rows && col < self.cols, "Index out of range")
            let index = self.cols * row + col
            self.items[index] = newItem
        }
    }
    
    
    static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
        assert(lhs.rows == rhs.rows && lhs.cols == rhs.cols, "Matrices of different sizes")
        var result = Matrix(rows: lhs.rows, cols: lhs.cols)
        for row in 0 ..< lhs.rows {
            for col in 0 ..< lhs.cols {
                result[row, col] = lhs[row, col] + rhs[row, col]
            }
        }
        return result
    }
    
    
    static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
        assert(lhs.rows == rhs.rows && lhs.cols == rhs.cols, "Matrices of different sizes")
        var result = Matrix(rows: lhs.rows, cols: lhs.cols)
        for row in 0 ..< lhs.rows {
            for col in 0 ..< lhs.cols {
                result[row, col] = lhs[row, col] - rhs[row, col]
            }
        }
        return result
    }
    
    
    static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        assert(lhs.cols == rhs.rows, "Matrices of incompatible size")
        var result = Matrix(rows: lhs.rows, cols: rhs.cols)
        for row in 0 ..< lhs.rows {
            for col in 0 ..< rhs.cols {
                result[row, col] = 0
                for i in 0 ..< lhs.cols {
                    result[row, col] += lhs[row, i] * rhs[i, col]
                }
            }
        }
        return result
    }
    
    
    static func *(lhs: Decimal, rhs: Matrix) -> Matrix {
        var result = rhs
        result.items = result.items.map { $0 * lhs }
        return result
    }
    
    
    static func *(lhs: Matrix, rhs: Decimal) -> Matrix {
        var result = lhs
        result.items = result.items.map { $0 * rhs }
        return result
    }
    
    
    static func ^^(lhs: Matrix, rhs: UInt) -> Matrix {
        assert(lhs.rows == lhs.cols, "Matrix has to be square")
        assert(rhs > 1, "Power should be greater than 1")
        var result = lhs
        for _ in 1 ..< rhs {
            result = result * lhs
        }
        return result
    }
    
    
}
