//
//  ObservableHumanMVVMViewModel.swift
//  ObservableHuman-RxSwift
//
//  Created by 平岡修 on 2021/03/30.
//

import UIKit
import RxSwift
import RxCocoa

class ObservableHumanMVVMViewModel {
    
    let userIsUnderAge: Observable<Bool>
    let selectedClothes: Observable<String>
    let selectedFootwear: Observable<String>
    let currentlyHumanImage: Observable<UIImage>

    init(
        userAgeString: Observable<String>,
        clothesValue: Observable<Int>,
        footwearValue: Observable<Int>) {
        
        userIsUnderAge = userAgeString
            .map { userAgeString in
                Int(userAgeString) ?? 0 >= 20
            }
            .share(replay: 1)
        
        selectedClothes = clothesValue
            .map { clothesValue in
                UISegmentedControl().selectedTitle(by: clothesValue,
                                                     segment0: "裸",
                                                     segment1: "服",
                                                     segment2: "網タイツ",
                                                     segment3: "Rx"
            )}
            .share(replay: 1)
        
        selectedFootwear = footwearValue
            .map { UISegmentedControl().selectedTitle(by: $0,
                                                      segment0: "靴下",
                                                      segment1: "裸足",
                                                      segment2: "ハイヒール",
                                                      segment3: "Rx"
            )}
            .share(replay: 1)
        
        currentlyHumanImage = Observable.combineLatest(selectedClothes, selectedFootwear){ clothes, footwear -> String in
            return clothes + "と" + footwear
        }
        .map { UIImage(named: $0) ?? UIImage(named: "裸と靴下")! }
        .share(replay: 1)
    }
}
