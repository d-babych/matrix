//
//  ViewController.swift
//  Matrix
//
//  Created by Dmytro Babych on 5/25/17.
//  Copyright © 2017 Babych Studio. All rights reserved.
//

import UIKit

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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

