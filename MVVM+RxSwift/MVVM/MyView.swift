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
            make.center.equalToSuperview()
        }
        
        addSubview(myButton)
        myButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(myLabel.snp.bottom).offset(20)
        }
    }
}

#Preview {
    MyViewController()
}
