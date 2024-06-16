//
//  ThrottleViewModel.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/16/24.
//

import RxCocoa
import RxSwift

protocol ThrottleViewModelType {
    var throttleTimerButtonTap: PublishRelay<Void> { get }
    var throttleUpdateLabelString: PublishSubject<String> { get }
    var throttleButtonTap1: PublishRelay<Void> { get }
    var throttleTapCount1: PublishSubject<Int> { get }
    var throttleButtonTap2: PublishRelay<Void> { get }
    var throttleTapCount2: PublishSubject<Int> { get }
}

final class ThrottleViewModel: ThrottleViewModelType {
    
    let throttleTimerButtonTap = PublishRelay<Void>()
    let throttleUpdateLabelString = PublishSubject<String>()
    private let timerEvent = PublishRelay<Void>()
    private var throttleValue = 0
    
    let throttleButtonTap1 = PublishRelay<Void>()
    let throttleTapCount1 = PublishSubject<Int>()
    private var tapCount1 = 0
    
    let throttleButtonTap2 = PublishRelay<Void>()
    let throttleTapCount2 = PublishSubject<Int>()
    private var tapCount2 = 0
    
    private let disposeBag = DisposeBag()
    private var timerDisposable: Disposable?
    
    init() {
        self.throttleTimerButtonTap
            .subscribe(onNext: {
                self.startTimer()
            })
            .disposed(by: disposeBag)
        
        self.timerEvent
            .do(onNext: {
                self.throttleValue += 1
            })
            .throttle(.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.throttleUpdateLabelString.onNext("[정기 업데이트 결과 (3초 단위)]\n👉\(self.throttleValue)")
            })
            .disposed(by: disposeBag)
        
        self.throttleButtonTap1
            .do(onNext: {
                self.tapCount1 += 1
            })
            .throttle(.seconds(3), latest: true, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.throttleTapCount1.onNext(self.tapCount1)
            })
            .disposed(by: disposeBag)
        
        self.throttleButtonTap2
            .do(onNext: {
                self.tapCount2 += 1
            })
            .throttle(.seconds(3), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.throttleTapCount2.onNext(self.tapCount2)
            })
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
