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
            .bind(to: underAgeGateView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    

}
