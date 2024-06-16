//
//  MainViewController.swift
//  MVVM+RxSwift
//
//  Created by 김영빈 on 6/14/24.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
    
    let cover = UIView()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let tableVCList: [(name: String, vc: UIViewController)] = [
        ("MVVM+RxSwift 기본", MyViewController()),
        ("Bind 테스트", BindViewController()),
        ("타이머 테스트", TimerViewController()),
        ("CombineLatest 테스트", CLViewController()),
        ("Debounce 테스트", DebounceViewController()),
        ("Throttle 테스트", ThrottleViewController())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(cover)
        cover.backgroundColor = .clear
        cover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cover.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableVCList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        
        cell.textLabel?.text = tableVCList[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "RxSwift 테스트"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {

            header.textLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = tableVCList[indexPath.row].vc
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    MainViewController()
}
