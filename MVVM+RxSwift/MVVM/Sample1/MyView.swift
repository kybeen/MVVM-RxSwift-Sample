//
//  MyView.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 3/19/24.
//

import UIKit
import SnapKit

final class MyView: UIView {
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Number : "
        return label
    }()
    
    lazy var myButton: UIButton = {
        let config = UIButton.Configuration.filled()
        var button = UIButton(configuration: config)
        button.setTitle("버튼", for: .normal)
        return button
    }()
    
    lazy var bindTestLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "흠..."
        return label
    }()
    lazy var bindTestButton: UIButton = {
        let config = UIButton.Configuration.filled()
        var button = UIButton(configuration: config)
        button.setTitle("Bind Test", for: .normal)
        return button
    }()
    
    lazy var leftRightNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "(왼쪽숫자) : (오른쪽숫자)"
        return label
    }()
    lazy var numStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    lazy var leftNumButton: UIButton = {
        let config = UIButton.Configuration.filled()
        var button = UIButton(configuration: config)
        button.setTitle("왼쪽 숫자", for: .normal)
        return button
    }()
    lazy var rightNumButton: UIButton = {
        let config = UIButton.Configuration.filled()
        var button = UIButton(configuration: config)
        button.setTitle("오른쪽 숫자", for: .normal)
        return button
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
        
        addSubview(myLabel)
        myLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        addSubview(myButton)
        myButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(myLabel.snp.bottom).offset(20)
        }
        
        addSubview(bindTestLabel)
        bindTestLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(myButton.snp.bottom).offset(20)
        }
        addSubview(bindTestButton)
        bindTestButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bindTestLabel.snp.bottom).offset(20)
        }
        
        addSubview(leftRightNumLabel)
        leftRightNumLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bindTestButton.snp.bottom).offset(20)
        }
        addSubview(numStackView)
        numStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(leftRightNumLabel.snp.bottom).offset(20)
        }
        numStackView.addArrangedSubview(leftNumButton)
        numStackView.addArrangedSubview(rightNumButton)
    }
}

#Preview {
    MyViewController()
}
