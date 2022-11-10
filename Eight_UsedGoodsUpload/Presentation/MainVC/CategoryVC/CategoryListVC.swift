//
//  CategoryListVC.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift
import Then
import SnapKit

class CategoryListVC : UIViewController{
    let bag = DisposeBag()
    let tableView = UITableView().then{
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryListCell")
        $0.backgroundColor = .white
        $0.dataSource = nil
        $0.tableFooterView = UIView()
        $0.separatorStyle = .singleLine
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryListVC{
    private func layout(){
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func attribute(){
        self.view.backgroundColor = .white
    }
    
    func bind(viewModel : CategoryViewModel){
        viewModel.cellData
            .drive(self.tableView.rx.items){ tv , row, data in
                let cell = tv.dequeueReusableCell(withIdentifier: "CategoryListCell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = data.name
                return cell
            }
            .disposed(by: self.bag)
        
        self.tableView.rx.modelSelected(Category.self)
            .asSignal(onErrorSignalWith: .empty())
            .emit(to: viewModel.itemSeleted)
            .disposed(by: self.bag)
        
        viewModel.pop
            .emit(to: self.navigationController!.rx.popNavation)
            .disposed(by: self.bag)
    }
}

extension Reactive where Base : UINavigationController{
    var popNavation : Binder<Void>{
        return Binder(base) { base, _ in
            base.popViewController(animated: true)
        }
    }
}
