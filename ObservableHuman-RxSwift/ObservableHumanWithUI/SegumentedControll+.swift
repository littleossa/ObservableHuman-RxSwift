//
//  SegumentedControll+.swift
//  ObservableHuman-RxSwift
//
//  Created by 平岡修 on 2021/03/30.
//

import UIKit
import RxSwift
import RxCocoa

extension UISegmentedControl {
    
    func selectedTitle(by value: Int, segment0: String, segment1: String, segment2: String, segment3: String) -> String {
        
        switch value {
        case 1:
            return segment1
        case 2:
            return segment2
        case 3:
            return segment3
        default:
            return segment0
        }
    }
}

