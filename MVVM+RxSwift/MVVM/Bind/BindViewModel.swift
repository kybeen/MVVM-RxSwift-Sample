//
//  BindViewModel.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import RxCocoa
import RxSwift

protocol BindViewModelType {
    var bindTestTap: PublishRelay<Void> { get }
    var bindTestString: PublishSubject<String> { get }
}

final class BindViewModel: BindViewModelType {
    
    let bindTestTap = PublishRelay<Void>()
    let bindTestString = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    init() {
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
