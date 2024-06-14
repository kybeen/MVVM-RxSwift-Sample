//
//  CLView.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import UIKit
import SnapKit

final class CLView: UIView {
    
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
        
        addSubview(leftRightNumLabel)
        leftRightNumLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
    CLViewController()
}
