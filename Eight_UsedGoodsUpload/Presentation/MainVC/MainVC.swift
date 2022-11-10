//
//  MainVC.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/08.
//

import UIKit

import RxSwift
import RxCocoa
import Then
import SnapKit

class MainVC : UIViewController{
    
    let tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.tableFooterView = UIView()
        $0.separatorStyle = .singleLine
    }
    let submitBtn = UIBarButtonItem().then{
        $0.title = "제출"
        $0.style = .done
    }
    
    let bag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainVC{
    func bind(viewModel : MainViewModel){
        
    }
    
    private func attribute(){
        self.title = "중고거래 등록"
        self.view.backgroundColor = .white
        self.navigationItem.setRightBarButton(self.submitBtn, animated: true)
        self.tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryListCell")
        self.tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell")
        self.tableView.register(DetailWirteFormCell.self, forCellReuseIdentifier: "DetailWirteFormCell")
    }
    
    private func layout(){
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title : String, msg : String?)
extension Reactive where Base : MainVC{
    var setAlert : Binder<Alert>{
        return Binder(base){base, data in
            let alert = UIAlertController(title: data.title, message: data.msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            base.present(alert, animated: true)
        }
    }
}
