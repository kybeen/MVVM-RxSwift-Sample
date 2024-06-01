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
    
    var timerTap: PublishRelay<Void> { get }
    var timerEvent: PublishRelay<Void> { get }
    var timerString: PublishSubject<String> { get }
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
    
    
    let timerTap = PublishRelay<Void>()
    let timerEvent = PublishRelay<Void>()
    let timerString = PublishSubject<String>()
    
    private let model = BehaviorRelay<MyModel>(value: .init(number: 100))
    
    let disposeBag = DisposeBag()
    var timerDisposable: Disposable? // 타이머 구독을 따로 종료하기 위한 Disposable
    
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
        
        self.timerTap
            .subscribe(onNext: {
                self.timerString.onNext("o")
                self.startTimer()
            })
            .disposed(by: disposeBag)
        
        self.timerEvent
            .withLatestFrom(timerString)
            .map { timerString -> String in
                var prevTimerString = timerString
                prevTimerString += "o"
                return prevTimerString
            }
            .bind(to: self.timerString)
            .disposed(by: disposeBag)
    }
    
    private func startTimer() {
        print("타이머 시작")
        timerDisposable?.dispose()
        timerDisposable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .take(30)
            .withUnretained(self)
            .subscribe(onNext: { _ in
                self.timerEvent.accept(())
            })
        
        timerDisposable?.disposed(by: disposeBag)
    }
}
