//
//  MatrixTests.swift
//  MatrixTests
//
//  Created by Dmytro Babych on 5/25/17.
//  Copyright © 2017 Babych Studio. All rights reserved.
//

import XCTest
import Accelerate
@testable import Matrix

class MatrixTests: XCTestCase {
    
    var mtrxA = Matrix<Float>(rows: 8, cols: 8)
    var mtrxB = Matrix<Float>(rows: 8, cols: 8)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var eltsA = [Float]()
        var eltsB = [Float]()
        for _ in 0 ..< 64 {
            let elA : Float = Float(arc4random()) * 4 / Float(Int32.max) - 2
            eltsA.append(elA)
            let elB : Float = Float(arc4random()) * 4 / Float(Int32.max) - 2
            eltsB.append(elB)
        }
        self.mtrxA = Matrix<Float>(rows: 8, cols: 8, items: eltsA)
        self.mtrxB = Matrix<Float>(rows: 8, cols: 8, items: eltsB)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMatrixMultiplicationPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Testing preformance of Matrix.* method
            for _ in 0 ..< 1000 {
                let _ = self.mtrxA * self.mtrxB
            }
        }
    }
    
    func testAccelerateMultiplicationPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Testing preformance of Accelerate.cblas_sgemm() method
            var mtrxD = Matrix<Float>(rows: self.mtrxA.rows, cols: self.mtrxB.cols)
            for _ in 0 ..< 1000 {
                cblas_sgemm(CBLAS_ORDER.init(101), CBLAS_TRANSPOSE.init(111), CBLAS_TRANSPOSE.init(111), Int32(self.mtrxA.rows), Int32(self.mtrxB.cols), Int32(self.mtrxA.cols), 1.0, self.mtrxA.items, Int32(self.mtrxA.cols), self.mtrxB.items, Int32(self.mtrxB.cols), 0.0, &mtrxD.items, Int32(mtrxD.cols))
            }
        }
    }
    
}
