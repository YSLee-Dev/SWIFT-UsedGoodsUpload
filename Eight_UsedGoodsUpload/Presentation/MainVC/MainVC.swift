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
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainVC{
    func bind(viewModel : MainViewModel){
        viewModel.cellData
            .drive(self.tableView.rx.items){tv, row, data in
                switch row{
                case 0:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "TitleTextFieldCell", for: IndexPath(row: row, section: 0)) as? TitleTextFieldCell else {return UITableViewCell()}
                    cell.selectionStyle = .none
                    cell.titleInputField.placeholder = data
                    cell.bind(viewModel: viewModel.titleTextFieldViewModel)
                    return cell
                case 1:
                   let cell = tv.dequeueReusableCell(withIdentifier: "CategoryListCell", for: IndexPath(row: row, section: 0))
                    cell.selectionStyle = .none
                    cell.accessoryType = .disclosureIndicator
                    
                    var contents = cell.defaultContentConfiguration()
                    contents.text = data
                    cell.contentConfiguration = contents
                    return cell
                case 2:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "PriceTextFieldCell", for: IndexPath(row: row, section: 0)) as? PriceTextFieldCell else {return UITableViewCell()}
                    cell.selectionStyle = .none
                    cell.priceInputField.placeholder = data
                    cell.bind(viewModel: viewModel.priceTextFieldViewModel)
                    return cell
                case 3:
                    guard let cell = tv.dequeueReusableCell(withIdentifier: "DetailWirteFormCell", for: IndexPath(row: row, section: 0)) as? DetailWirteFormCell else {return UITableViewCell()}
                    cell.selectionStyle = .none
                    cell.contentInputView.text = data
                    cell.bind(viewModel: viewModel.detailWirteFormViewModel)
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: self.bag)
        
        viewModel.presentAlert
            .bind(to: self.rx.setAlert)
            .disposed(by: self.bag)
        
        viewModel.push
            .drive(self.rx.categoryVCShow)
            .disposed(by: self.bag)
        
        self.tableView.rx.itemSelected
            .map{
                $0.row
            }
            .bind(to: viewModel.itemClick)
            .disposed(by: self.bag)
        
        self.submitBtn.rx.tap
            .bind(to: viewModel.submitBtnClick)
            .disposed(by: self.bag)
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
    
    var categoryVCShow : Binder<CategoryViewModel>{
        return Binder(base){base, data in
            let vc = CategoryListVC()
            vc.bind(viewModel: data)
            base.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
