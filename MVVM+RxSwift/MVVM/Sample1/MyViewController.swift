//
//  MyViewController.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 3/19/24.
//

/*
 ViewController에는 다음의 코드들이 들어감
 - UI 그리기
 - ViewModel의 데이터와 바인딩
 - 이벤트를 Input으로 넘기기
 */
import UIKit

import RxCocoa
import RxSwift

class MyViewController: UIViewController {
    
    let myView = MyView()
    var myViewModel: MyViewModelType = MyViewModel()
    var disposeBag = DisposeBag()
    
//    init(myViewModel: MyViewModelType) {
//        self.myViewModel = myViewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - UI 그리기
        view.addSubview(myView)
        myView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // MARK: - MyViewModel 데이터와 바인딩 + 이벤트 input으로 넘기기
        self.bind(viewModel: self.myViewModel as! MyViewModel)
    }

    private func bind(viewModel: MyViewModelType) {
        // ViewModel의 output을 ViewController(View)가 구독
        self.myViewModel.number
            .drive(self.myView.myLabel.rx.text) // Driver를 바인딩
            .disposed(by: self.disposeBag)
        
        // ViewController(View)에서 ViewModel의 input으로 명령을 보냄
        self.myView.myButton.rx.tap
            .bind(to: viewModel.tap)
            .disposed(by: self.disposeBag)
        
//        self.myView.timerButton.rx.tap
//            .bind(to: viewModel.timerTap)
//            .disposed(by: self.disposeBag)
//        
//        self.myViewModel.timerString
//            .bind(to: self.myView.timerLabel.rx.text)
//            .disposed(by: self.disposeBag)
        
        self.myView.bindTestButton.rx.tap
            .bind(to: viewModel.bindTestTap)
            .disposed(by: self.disposeBag)
        
        self.myViewModel.bindTestString
            .bind(to: self.myView.bindTestLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.myView.leftNumButton.rx.tap
            .bind(to: viewModel.leftNumButtonTap)
            .disposed(by: disposeBag)
        
        self.myView.rightNumButton.rx.tap
            .bind(to: viewModel.rightNumButtonTap)
            .disposed(by: disposeBag)
        
        self.myViewModel.leftRightNumString
            .bind(to: self.myView.leftRightNumLabel.rx.text)
            .disposed(by: disposeBag)
    }
}


