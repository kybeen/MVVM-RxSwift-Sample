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
    var tap: PublishRelay<Void> { get }
    var number: Driver<String> { get }
    
    var bindTestTap: PublishRelay<Void> { get }
    var bindTestString: PublishSubject<String> { get }
    
    var leftNumButtonTap: PublishRelay<Void> { get }
    var rightNumButtonTap: PublishRelay<Void> { get }
    var leftRightNumString: PublishSubject<String> { get }
}

final class MyViewModel: MyViewModelType {
    /*
     - Relay : 스트림이 끊어지지 않는 Relay (== 에러가 없는 Subject) 👉 데이터를 받아들이는 것만 가능
     - Driver : UI 스레드에서 돌아가는 Observable
     */
    
    let tap = PublishRelay<Void>()
    let number: Driver<String>
    
    let bindTestTap = PublishRelay<Void>()
    let bindTestString = PublishSubject<String>()
    
    let leftNumButtonTap = PublishRelay<Void>()
    let rightNumButtonTap = PublishRelay<Void>()
    let leftNum = PublishSubject<Int>()
    let rightNum = BehaviorSubject<Int>(value: 2)
    let leftRightNumString = PublishSubject<String>()
    
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
        
        
        self.bindTestTap
            .withUnretained(self)
            .subscribe(onNext: { _ in
                print("Bind Test!!!")
                self.bindTest()
                /*
                 onNext, onCompleted를 모두 전달하는 이벤트는 bind로 처리하면 안됨
                 */
                    .subscribe(onNext: {
                        self.bindTestString.onNext($0)
                    })
//                    .bind(to: self.bindTestString)
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        
        self.leftNumButtonTap
            .subscribe(onNext: {
                self.leftNum.onNext(Int.random(in: 0...100))
            })
            .disposed(by: disposeBag)
        self.rightNumButtonTap
            .subscribe(onNext: {
                self.rightNum.onNext(Int.random(in: 0...100))
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(leftNum, rightNum)
            .subscribe(onNext: {(left, right) in
                let newStr = "\(left) : \(right)"
                print(newStr)
                self.leftRightNumString.onNext(newStr)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTest() -> Observable<String> {
        return Observable.create { emitter in
            // onNext, onCompleted를 전달하는 이벤트
            emitter.onNext("\(Int.random(in: 0...100))")
            emitter.onCompleted()
            return Disposables.create()
        }
    }
}
