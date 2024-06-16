//
//  ThrottleViewController.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/16/24.
//

import UIKit

import RxCocoa
import RxSwift

class ThrottleViewController: UIViewController {
    
    let throttleView = ThrottleView()
    let throttleViewModel: ThrottleViewModelType = ThrottleViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(throttleView)
        throttleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.bind(viewModel: self.throttleViewModel)
    }
    
    private func bind(viewModel: ThrottleViewModelType) {
        self.throttleView.throttleTimerButton.rx.tap
            .bind(to: throttleViewModel.throttleTimerButtonTap)
            .disposed(by: disposeBag)
        
        self.throttleViewModel.throttleUpdateLabelString
            .bind(to: throttleView.throttleUpdateLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.throttleView.throttleButton1.rx.tap
            .bind(to: throttleViewModel.throttleButtonTap1)
            .disposed(by: disposeBag)
        
        self.throttleViewModel.throttleTapCount1.asDriver(onErrorJustReturn: -1)
            .drive(onNext: {
                self.throttleView.throttleLabel1.text! += "👉\($0)"
            })
            .disposed(by: disposeBag)
        
        self.throttleView.throttleButton2.rx.tap
            .bind(to: throttleViewModel.throttleButtonTap2)
            .disposed(by: disposeBag)
        
        self.throttleViewModel.throttleTapCount2.asDriver(onErrorJustReturn: -1)
            .drive(onNext: {
                self.throttleView.throttleLabel2.text! += "👉\($0)"
            })
            .disposed(by: disposeBag)
    }
}
