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
        
        let clothes = clothesControl.rx.value.asObservable()
            .map { UISegmentedControl().selectedTitle(by: $0,
                                                     segment0: "裸",
                                                     segment1: "服",
                                                     segment2: "網タイツ",
                                                     segment3: "Rx"
            )}
        
        let footwear = clothesControl.rx.value.asObservable()
            .map { UISegmentedControl().selectedTitle(by: $0,
                                                      segment0: "靴下",
                                                      segment1: "裸足",
                                                      segment2: "ハイヒール",
                                                      segment3: "Rx"
            )}
        
        let imageName = BehaviorRelay(value: "裸と靴下")
        
        imageName.map { UIImage(named: $0) }
            .bind(to: humanImage.rx.image)
            .disposed(by: disposeBag)
        
        userIsUnderAge.bind(to: underAgeGateView.rx.isHidden)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(clothes, footwear){ clothesValue, footwearValue -> String in
            clothesValue + "と" + footwearValue
        }
        .subscribe {
            imageName.accept($0)
        }
        .disposed(by: disposeBag)
    }
}
