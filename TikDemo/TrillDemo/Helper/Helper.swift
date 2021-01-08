//
//  Helper.swift
//  TrillDemo
//
//  Created by magic-devel on 2020/10/9.
//

import Foundation

extension Int {
    
    var towanStr: String {
        if self > 10000 {
            let a = Double(exactly: self)! / 10000.0
            return round(a).description + "W"
        }
        return self.description
    }
}
