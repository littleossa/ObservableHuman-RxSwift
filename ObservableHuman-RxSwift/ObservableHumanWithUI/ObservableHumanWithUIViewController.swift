//
//  ObservableHumanWithUIViewController.swift
//  ObservableHuman-RxSwift
//
//  Created by 平岡修 on 2021/03/27.
//

import UIKit
import RxSwift
import RxCocoa

class ObservableHumanWithUIViewController: UIViewController {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var clothesControl: UISegmentedControl!
    @IBOutlet weak var footwearControl: UISegmentedControl!
    @IBOutlet weak var humanImage: UIImageView!
    @IBOutlet weak var underAgeGateView: UIView!
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userIsUnderAge = ageTextField.rx.text.orEmpty.asObservable()
            .map { Int($0) ?? 0 >= 20 }
        
        userIsUnderAge.bind(to: underAgeGateView.rx.isHidden)
            .disposed(by: disposeBag)
        
        let clothes = clothesControl.rx.value.asObservable()
            .map { UISegmentedControl().selectedTitle(by: $0,
                                                     segment0: "裸",
                                                     segment1: "服",
                                                     segment2: "網タイツ",
                                                     segment3: "Rx"
            )}
            .share(replay: 1)
        
        let footwear = footwearControl.rx.value.asObservable()
            .map { UISegmentedControl().selectedTitle(by: $0,
                                                      segment0: "靴下",
                                                      segment1: "裸足",
                                                      segment2: "ハイヒール",
                                                      segment3: "Rx"
            )}
            .share(replay: 1)
        
        Observable.combineLatest(clothes, footwear){ clothesValue, footwearValue -> String in
            return clothesValue + "と" + footwearValue
        }
        .map { UIImage(named: $0) }
        .bind(to: humanImage.rx.image)
        .disposed(by: disposeBag)
    }
}
