//
//  ViewController.swift
//  Matrix
//
//  Created by Dmytro Babych on 5/25/17.
//  Copyright © 2017 Babych Studio. All rights reserved.
//

import UIKit
import Accelerate

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let a = Matrix<Double>(rows: 2, cols: 3, items: [1, 0.5, 2.5, 1, 2, 6])
        let b = Matrix<Double>(rows: 2, cols: 2, items: [2, 0, 0, 2])
        let b1 = Matrix<Double>(rows: 2, cols: 2, items: [3, 0, 0, 3])

        print("\(a)")
        print("\(b)")
        
        print("\(b1 * b ^^ 3)")
        
        let d = b * a
        print("\(d)")
        
        let c = a + d
        print("\(c)")
        
        let e = b * a + b * a
        print("\(e)")
        print("\(e * 2)")
        print("\(8 * e)")

        var eltsA = [Float]()
        var eltsB = [Float]()
        for _ in 0 ..< 64 {
            let elA : Float = Float(arc4random()) * 4 / Float(Int32.max) - 2
            eltsA.append(elA)
            let elB : Float = Float(arc4random()) * 4 / Float(Int32.max) - 2
            eltsB.append(elB)
        }
        let mtrxA = Matrix<Float>(rows: 8, cols: 8, items: eltsA)
        let mtrxB = Matrix<Float>(rows: 8, cols: 8, items: eltsB)
        
        print("Matrix A:\n\(mtrxA)\n")
        print("Matrix B:\n\(mtrxB)\n")
        
        let mtrxC = mtrxA * mtrxB
        print("Matrix C:\n\(mtrxC)\n")
        
        var mtrxD = Matrix<Float>(rows: mtrxA.rows, cols: mtrxB.cols)
        cblas_sgemm(CBLAS_ORDER.init(101), CBLAS_TRANSPOSE.init(111), CBLAS_TRANSPOSE.init(111), Int32(mtrxA.rows), Int32(mtrxB.cols), Int32(mtrxA.cols), 1.0, mtrxA.items, Int32(mtrxA.cols), mtrxB.items, Int32(mtrxB.cols), 0.0, &mtrxD.items, Int32(mtrxD.cols))
        print("Matrix D:\n\(mtrxD)\n")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

