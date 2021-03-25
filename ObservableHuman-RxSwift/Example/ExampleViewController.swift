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
        
//        undesiredLogic()
        improvedLogic()
    }
    
    // MARK: - 望んでいない振る舞いを行う通常のコード
    
    func undesiredLogic() {
        
        var clothes = "服" // 一度だけ変数clothesにString"服"が代入されます
        var footwear = "靴下" // 一度だけ変数footwearにString"靴下"が代入されます
        var humanOutfit = clothes + "と" + footwear // 一度だけ変数humanOutfitにclotesとfootwearを足した値が代入されます
        
        var witness = "まだ何も目撃していません" // 目撃者witnessはまだ何も目撃していません
        
        if humanOutfit.contains("服") { // 文字列に"服"を含むなら
            witness = "彼の格好は、\(humanOutfit)です" // 一度だけwitnessに値が代入されます
        }
        print("目撃者の証言：", witness)
        
        clothes = "ダウンジャケット"
        footwear = "スニーカー"
        print("目撃者の証言：", witness)
    }
    
    // MARK: - RxSwiftによって向上し、理想の振る舞いを行うコード
    
    func improvedLogic() {
        
        let clothes = BehaviorRelay(value: "服")   // clothes = "服"
        let footwear = BehaviorRelay(value: "靴下")   // footwear = "靴下"
        // clothesとfootwearを足した最新(現在)の値（Combines latest values) をwitnessに代入
        let witness = Observable.combineLatest(clothes, footwear) { $0 + "と" + $1 }
            .filter { $0.contains("服") }
            // もし 'clothes +　"と" + footwear'の値が "服" を含む（$0.constarains"服" = true）なら
            // 'clothes +　"と" + footwear'の値が下記mapオペレーターの引数に代入されます
            .map { "彼の格好は、\($0)です" }
        // witnessに代入した 'clothes + "と" + footwear' を文字列 "彼の格好は、\(clothes + "と" + footwear)です"　に変換されました
        // clothes = "服" と footwear = "靴下"　という初期値なので
        // 現在の、witnessの値は "彼の格好は、服と靴下です"
        witness.subscribe(onNext: { print("目撃者の証言：", $0) }) // print: "目撃者の証言: 彼の格好は、服と靴下です"
        // witness.subscribeというのは、'Observable'のwitnessから値を引き出すという処理で
        // 'subscribe(onNext:)' は次の値に切り替わった(on next Value)時の最新の値を引き出すということを意味し、値が変化する度に'subscribe(onNext:)'の処理が実行されます
        // この時点で、"目撃者の証言: 彼の格好は、服と靴下です"
        
        // じゃあ、今から `footwear`　の値を変えてみましょう
        // acceptメソッドは受け取った値をsubscriberに渡します
        footwear.accept("スニーカー")                                   // prints: "彼の格好は、服とスニーカーです"
        // これで`clotes +　"と"　+ footwear` を足した最新の値は、 `"服"　+ "と" + "スニーカー"`　になっています
        // `witness.contains("服") = true` なので、filter処理を通過し, mapオペレーターによって "彼の格好は、服とスニーカーです"という文字列に変換されます
        // そして、その結果がwitnessに代入されます
        // witnessの値が最新の値に変更されたので, `{ print("目撃者の証言：", $0) }` という処理が呼び出され、
        // "目撃者の証言: 彼の格好は、服とスニーカーです" がログに出力されます
        
        // では、clothesの値を変更してみましょう
        clothes.accept("裸")                                 // 何も出力されません
        // `clotes +　"と"　+ footwear` を足した最新の値は、 `"裸"　+ "と" + "スニーカー"`になっています
        //  `witness.contains("服")` というfilter処理の条件に当てはまらない為、通過できず map処理が行われません。
        // map処理が行われないということは、witnessの値は"彼の格好は、服とスニーカーです"のままになります。
        // 最新の値に更新が無い為、最新の値を引き出すsubscribe（onNext:）処理も呼び出されません
        // よって `{ print("目撃者の証言：", $0) }` の処理が実行されない仕組みです
    }
    
}
