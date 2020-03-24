//
//  Dynamic.swift
//  Velocity Bom
//
//  Created by silsila on 03/01/19.
//  Copyright © 2019 Credencys. All rights reserved.
//

import Foundation

/// This is for textfield binding
class Dynamic<T> {
    
    ///
    var bind: (T) -> Void = {_ in }
    
    ///
    var value: T? {
        didSet {
            guard let value = value else { return } // Hemant Change
            bind(value)
        }
    }
    
    /// initialization of value
    ///
    /// - Parameter val: set value
    init(_ val: T) {
        value = val
    }
    
}
