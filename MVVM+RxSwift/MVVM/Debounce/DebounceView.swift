//
//  DebounceView.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import UIKit
import SnapKit

final class DebounceView: UIView {
    
    lazy var debounceTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "디바운스"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var debouncePayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "결제 결과"
        return label
    }()
    
    lazy var debouncePayButton: UIButton = {
        let config = UIButton.Configuration.filled()
        var button = UIButton(configuration: config)
        button.setTitle("💸 100원 결제하기 (Debounce)", for: .normal)
        return button
    }()
    
    lazy var debounceSearchResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "검색 결과"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var debounceSearchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "검색어를 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUI() {
        self.backgroundColor = .white
        
        addSubview(debounceTitle)
        debounceTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        addSubview(debouncePayLabel)
        debouncePayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(debounceTitle.snp.bottom).offset(20)
        }
        
        addSubview(debouncePayButton)
        debouncePayButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(debouncePayLabel.snp.bottom).offset(20)
        }
        
        addSubview(debounceSearchTextField)
        debounceSearchTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(debouncePayButton.snp.bottom).offset(50)
        }
        
        addSubview(debounceSearchResultLabel)
        debounceSearchResultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(debounceSearchTextField.snp.bottom).offset(20)
        }
    }
}

#Preview {
    DebounceViewController()
}
