//
//  CLViewModel.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import RxCocoa
import RxSwift

protocol CLViewModelType {
    var leftNumButtonTap: PublishRelay<Void> { get }
    var rightNumButtonTap: PublishRelay<Void> { get }
    var leftRightNumString: PublishSubject<String> { get }
}

final class CLViewModel: CLViewModelType {
    
    let leftNumButtonTap = PublishRelay<Void>()
    let rightNumButtonTap = PublishRelay<Void>()
    let leftNum = PublishSubject<Int>()
    let rightNum = PublishSubject<Int>()
    let leftRightNumString = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    init() {
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
}
