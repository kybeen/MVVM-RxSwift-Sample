//
//  TimerViewController.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import UIKit

import RxCocoa
import RxSwift

class TimerViewController: UIViewController {
    
    let timerView = TimerView()
    let timerViewModel: TimerViewModelType = TimerViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(timerView)
        timerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // MARK: - MyViewModel 데이터와 바인딩 + 이벤트 input으로 넘기기
        self.bind(viewModel: self.timerViewModel as! TimerViewModelType)
    }
    
    private func bind(viewModel: TimerViewModelType) {
        self.timerView.timerButton.rx.tap
            .bind(to: viewModel.timerTap)
            .disposed(by: self.disposeBag)
        
        self.timerViewModel.timerString
            .bind(to: self.timerView.timerLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}
