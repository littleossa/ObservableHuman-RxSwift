//
//  ExampleViewController.swift
//  ObservableHuman-RxSwift
//
//  Created by 平岡修 on 2021/03/25.
//

import UIKit
import RxSwift
import RxCocoa

class ExampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello, The Observable Human!!")
        undesiredLogic()
        //        improvedLogic()
    }
    
    // MARK: - 望んでいない振る舞いを行う通常のコード
    
    func undesiredLogic() {
        
        var clothes = "裸" // 変数clothesにString"裸"を代入します
        var footwear = "靴下" // 一度だけ変数footwearにString"靴下"を代入します
        
        var looks = clothes + "と" + footwear // 変数looksにclotesとfootwearを足した値を代入します
        
        print("目撃者の証言1：　彼の格好は、\(looks)です") // 目撃者の証言1：　彼の格好は、裸と靴下です
        
        clothes = "服" // 変数clothesの値を"服"に置き換えました
        
        print("目撃者の証言２：　彼の格好は、\(looks)です") // 目撃者の証言2：　彼の格好は、裸と靴下です
        
    }
    
    // MARK: - RxSwiftによって向上し、理想の振る舞いを行うコード
    
    func improvedLogic() {
        
        let clothes = BehaviorRelay(value: "裸")   // clothes = "裸"
        let footwear = BehaviorRelay(value: "靴下")   // footwear = "靴下"
        // clothesとfootwearを足した最新(現在)の値（Combines latest values) をwitnessに代入
        let looks = Observable.combineLatest(clothes, footwear) { $0 + "と" + $1 }
            //            .filter { $0.contains("服") }
            // もし `clothes +　"と" + footwear` の値が "服" を含む（$0.constarains"服" = true）なら
            // `clothes +　"と" + footwear` の値が下記mapオペレーターの引数に代入されます
            // falseの場合は、mapオペレーター以下の処理は実行されません
            .map { "彼の格好は、\($0)です" }
        // looksに代入した 'clothes' と `footwear` を文字列 "彼の格好は、\(clothes + "と" + footwear)です"　に変換されました
        // clothes = "裸" と footwear = "靴下"　という初期値なので
        // 現在の、looksの値は "彼の格好は、裸と靴下です"
        looks.subscribe(onNext: { print("目撃者の証言：", $0) }) // print: "目撃者の証言: 彼の格好は、裸と靴下です"
        // looks.subscribeというのは、<Observable>のlooksから値を引き出すという処理で
        // 'subscribe(onNext:)' は次の値に切り替わった(on next Value)時の最新の値を引き出すということを意味し、値が変化する度に'subscribe(onNext:)'の処理が実行されます
        // この時点で、"目撃者の証言: 彼の格好は、裸と靴下です"
        
        // じゃあ、今から `clothes`　の値を変えてみましょう
        // acceptメソッドは受け取った値をsubscriberに渡します
        footwear.accept("スニーカー")                                   // print: "目撃者の証言： 彼の格好は、裸とスニーカーです"
        // これで`clotes +　"と"　+ footwear` を足した最新の値は、 `"服"　+ "と" + "スニーカー"`　になっています
        // `witness.contains("服") = true` なので、filter処理を通過し, mapオペレーターによって "彼の格好は、裸とスニーカーです"という文字列に変換されます
        // そして、その結果がlooksに代入されます
        // looksの値が最新の値に変更されたので, `subscribe(onNext: { print("目撃者の証言：", $0) }` 処理が呼び出され、
        // "目撃者の証言: 彼の格好は、裸とスニーカーです" がログに出力されます
        
        // では、clothesの値を変更してみましょう
        clothes.accept("服")                                 //　print: "彼の格好は、服とスニーカーです"
        // `clotes +　"と"　+ footwear` を足した最新の値は、 `"裸"　+ "と" + "スニーカー"`になったのでmapオペレーターを経由して`subscribe(onNext: { print("目撃者の証言：", $0) }`が再度呼び出され、
        // "目撃者の証言: 彼の格好は、服とスニーカーです" がログに出力されます
    }
    
}
