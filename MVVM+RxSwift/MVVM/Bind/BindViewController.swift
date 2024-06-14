//
//  BindViewController.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class BindViewController: UIViewController {
    
    let bindView = BindView()
    let bindViewModel: BindViewModelType = BindViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bindView)
        bindView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bind(viewModel: self.bindViewModel)
    }
    
    private func bind(viewModel: BindViewModelType) {
        self.bindView.bindTestButton.rx.tap
            .bind(to: bindViewModel.bindTestTap)
            .disposed(by: self.disposeBag)
        
        self.bindViewModel.bindTestString
            .bind(to: self.bindView.bindTestLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}
