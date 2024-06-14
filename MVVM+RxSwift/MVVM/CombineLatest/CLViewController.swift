//
//  CLViewController.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import UIKit

import RxCocoa
import RxSwift

class CLViewController: UIViewController {
    
    let clView = CLView()
    let clViewModel: CLViewModelType = CLViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(clView)
        clView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.bind(viewModel: self.clViewModel)
    }
    
    private func bind(viewModel: CLViewModelType) {
        self.clView.leftNumButton.rx.tap
            .bind(to: viewModel.leftNumButtonTap)
            .disposed(by: disposeBag)
        
        self.clView.rightNumButton.rx.tap
            .bind(to: viewModel.rightNumButtonTap)
            .disposed(by: disposeBag)
        
        self.clViewModel.leftRightNumString
            .bind(to: self.clView.leftRightNumLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
