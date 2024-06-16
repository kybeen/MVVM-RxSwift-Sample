//
//  ThrottleView.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/16/24.
//

import UIKit
import SnapKit

final class ThrottleView: UIView {
    
    lazy var throttleTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "쓰로틀링"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var throttleTimerButton: UIButton = {
        let config = UIButton.Configuration.filled()
        var button = UIButton(configuration: config)
        button.setTitle("⏱️ 타이머 시작 (Throttle)", for: .normal)
        return button
    }()
    
    lazy var throttleUpdateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "[정기 업데이트 결과 (3초 단위)]"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var throttleButton1: UIButton = {
        let config = UIButton.Configuration.filled()
        var button = UIButton(configuration: config)
        button.setTitle("👆 Throttle 탭 버튼 1 (latest=true)", for: .normal)
        return button
    }()
    
    lazy var throttleLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "탭 횟수 : "
        label.numberOfLines = 0
        return label
    }()
    
    lazy var throttleButton2: UIButton = {
        let config = UIButton.Configuration.filled()
        var button = UIButton(configuration: config)
        button.setTitle("👆 Throttle 탭 버튼 2 (latest=false)", for: .normal)
        return button
    }()
    
    lazy var throttleLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "탭 횟수 : "
        label.numberOfLines = 0
        return label
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
        
        addSubview(throttleTitle)
        throttleTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        addSubview(throttleTimerButton)
        throttleTimerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(throttleTitle.snp.bottom).offset(20)
        }
        
        addSubview(throttleUpdateLabel)
        throttleUpdateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(throttleTimerButton.snp.bottom).offset(20)
        }
        
        addSubview(throttleButton1)
        throttleButton1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(throttleUpdateLabel.snp.bottom).offset(50)
        }
        
        addSubview(throttleLabel1)
        throttleLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(throttleButton1.snp.bottom).offset(20)
        }
        
        addSubview(throttleButton2)
        throttleButton2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(throttleLabel1.snp.bottom).offset(30)
        }
        
        addSubview(throttleLabel2)
        throttleLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(throttleButton2.snp.bottom).offset(20)
        }
    }
}

#Preview {
    ThrottleViewController()
}
