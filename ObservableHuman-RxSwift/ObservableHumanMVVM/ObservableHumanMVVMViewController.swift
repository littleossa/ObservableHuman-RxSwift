//
//  ObservableHumanMVVMViewController.swift
//  ObservableHuman-RxSwift
//
//  Created by 平岡修 on 2021/03/30.
//

import UIKit
import RxSwift
import RxCocoa

class ObservableHumanMVVMViewController: UIViewController {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var clothesControl: UISegmentedControl!
    @IBOutlet weak var footwearControl: UISegmentedControl!
    @IBOutlet weak var humanImage: UIImageView!
    @IBOutlet weak var underAgeGateView: UIView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = ObservableHumanMVVMViewModel.init(
            userAgeString: ageTextField.rx.text.orEmpty.asObservable(),
            clothesValue: clothesControl.rx.value.asObservable(),
            footwearValue: footwearControl.rx.value.asObservable()
        )
        
        // MARK: - viewModel's bind result
        
        viewModel.userIsUnderAge
            .bind(to: underAgeGateView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.currentlyHumanImage
            .bind(to: humanImage.rx.image)
            .disposed(by: disposeBag)
        
        // MARK: - Tap Guesture
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
    }
}
