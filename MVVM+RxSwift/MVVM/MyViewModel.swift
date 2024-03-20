//
//  MyViewModel.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 3/19/24.
//

import RxCocoa
import RxSwift

// ViewModel이 받을 input/output 정의
protocol MyViewModelType {
    var tap: PublishRelay<Void> { get } // input
    var number: Driver<String> { get } // output
}

final class MyViewModel: MyViewModelType {
    /*
     - Relay : 스트림이 끊어지지 않는 Relay (== 에러가 없는 Subject) 👉 데이터를 받아들이는 것만 가능
     - Driver : UI 스레드에서 돌아가는 Observable
     */
    
    // input
    let tap = PublishRelay<Void>()
    
    // output
    let number: Driver<String>
    
    private let model = BehaviorRelay<MyModel>(value: .init(number: 100))
    
    let disposeBag = DisposeBag()
    
    init() {
        // Model에서 발생한 notification은 ViewModel의 init에서 다룸
        self.number = self.model
            .map { "Number: \($0.number)" }
            .asDriver(onErrorRecover: { _ in .empty() })
        
        // ViewModel은 View(ViewController)의 명령을 받아 Model에 반영
        self.tap
            .withLatestFrom(model)
            .map { model -> MyModel in
                var nextModel = model
                nextModel.number += 1
                return nextModel
            }.bind(to: self.model)
            .disposed(by: disposeBag)
    }
}
