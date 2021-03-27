//
//  ObservableHumanWithUIViewController.swift
//  ObservableHuman-RxSwift
//
//  Created by 平岡修 on 2021/03/27.
//

import UIKit

class ObservableHumanWithUIViewController: UIViewController {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var clothesControl: UISegmentedControl!
    @IBOutlet weak var footwearControl: UISegmentedControl!
    @IBOutlet weak var humanImage: UIImageView!
    @IBOutlet weak var underAgeGateView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        underAgeGateView.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
