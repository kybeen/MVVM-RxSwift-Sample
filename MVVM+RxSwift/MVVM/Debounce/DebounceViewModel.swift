//
//  DebounceViewModel.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import RxCocoa
import RxSwift

protocol DebounceViewModelType {
    var debouncePayButtonTap: PublishRelay<Void> { get }
    var debouncePayLabelString: PublishSubject<String> { get }
    var debounceChangedText: PublishRelay<String> { get }
    var debounceSearchResultLabel: PublishSubject<String> { get }
}

final class DebounceViewModel: DebounceViewModelType {
    
    let debouncePayButtonTap = PublishRelay<Void>()
    let debouncePayLabelString = PublishSubject<String>()
    private var debouncePayedMoney = 0
    
    let debounceChangedText = PublishRelay<String>()
    let debounceSearchResultLabel = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.debouncePayButtonTap
            .debounce(.seconds(3), scheduler: MainScheduler.instance)
            .do(onNext: {
                self.debouncePayedMoney += 100
            })
            .subscribe(onNext: {
                self.debouncePayLabelString.onNext("총 \(self.debouncePayedMoney)원 결제 완료💸💸💸")
            })
            .disposed(by: disposeBag)
        
        self.debounceChangedText
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { newText in
                let result = "검색 결과\n\(newText)\n\(newText)\n\(newText)\n\(newText)\n\(newText)"
                self.debounceSearchResultLabel.onNext(result)
            })
            .disposed(by: disposeBag)
    }
}
