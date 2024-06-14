//
//  BindView.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import UIKit
import SnapKit

final class BindView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUI() {
        addSubview(bindTestLabel)
        bindTestLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        addSubview(bindTestButton)
        bindTestButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bindTestLabel.snp.bottom).offset(20)
        }
    }
}

#Preview {
    BindViewController()
}
