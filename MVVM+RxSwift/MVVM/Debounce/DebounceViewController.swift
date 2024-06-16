//
//  DebounceViewController.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import UIKit

import RxCocoa
import RxSwift

class DebounceViewController: UIViewController {
    
    let debounceView = DebounceView()
    let debounceViewModel: DebounceViewModelType = DebounceViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(debounceView)
        debounceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.bind(viewModel: self.debounceViewModel)
    }
    
    private func bind(viewModel: DebounceViewModelType) {
        self.debounceView.debouncePayButton.rx.tap
            .bind(to: debounceViewModel.debouncePayButtonTap)
            .disposed(by: disposeBag)
        
        self.debounceViewModel.debouncePayLabelString
            .bind(to: debounceView.debouncePayLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.debounceView.debounceSearchTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: debounceViewModel.debounceChangedText)
            .disposed(by: disposeBag)
        
        self.debounceViewModel.debounceSearchResultLabel
            .bind(to: debounceView.debounceSearchResultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
