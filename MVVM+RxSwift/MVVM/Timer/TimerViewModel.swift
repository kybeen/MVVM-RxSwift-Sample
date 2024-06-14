//
//  TimerViewModel.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import RxCocoa
import RxSwift

protocol TimerViewModelType {
    var timerTap: PublishRelay<Void> { get }
    var timerEvent: PublishRelay<Void> { get }
    var timerString: PublishSubject<String> { get }
}

final class TimerViewModel: TimerViewModelType {
    
    let timerTap = PublishRelay<Void>()
    let timerEvent = PublishRelay<Void>()
    let timerString = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    var timerDisposable: Disposable? // 타이머 구독을 따로 종료하기 위한 Disposable
    
    init() {
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
