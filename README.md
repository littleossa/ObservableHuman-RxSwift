# ObservableHuman-RxSwift
RxSwift学習の為に公式ドキュメント内Examples "<b>ReactiveValues</b>"の章の内容を自分なりに噛み砕いて作成した学習用サンプル

コードのみの挙動を確認できるExampleと、

UIと結び付けを行ったObservableHumanWithUIと、

それをさらにMVVMで設計したObservableHumanMVVMのstoryboardがあります。
 
# DEMO

![ObservableHumanDemo](https://user-images.githubusercontent.com/67716751/113144934-c851f300-9268-11eb-86c6-234524982f5f.GIF)

# Features

年齢認証用のTextFieldの値を監視しており、入力された値が２０未満であれば`underAgeGateView`(未成年ゲート)が表示されます（`.isHiden = false`）。

また、衣類用の`UISegmentedControl`と足下用の`UISegmentedControl`の選択されたIndexのtitleを監視しています。

上記の二つのtitleを`combineLatest`で合算し、`UIImageView`に反映する為にmapオペレーターで`UIImageView`に変換しています。

その結果を`humanImageView`にバインドを行っています。
 
# Requirement
 
* RxSwift
* RxCocoa
 
# Installation
  
```
pod 'RxSwift', '~> 4.0'
pod 'RxCocoa', '~> 4.0'
```
 
# Note
 
初期設定では、`ObservableHumanMVVM.storyboard`に遷移するようになっております。
コードサンプルのみの挙動が見たい場合は遷移先を`Example.storyboard`に変更して下さい。

# Reference

[RxSwift/Documentation/Examples](https://github.com/ReactiveX/RxSwift/blob/main/Documentation/Examples.md#automatic-input-validation)
