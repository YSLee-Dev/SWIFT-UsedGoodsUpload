//
//  TitleTextFieldCell.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class TitleTextFieldCell : UITableViewCell{
    let bag = DisposeBag()
    
    let titleInputField = UITextField().then{
        $0.placeholder = "제목을 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleTextFieldCell {
    private func layout(){
        self.contentView.addSubview(self.titleInputField)
        self.titleInputField.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(15)
        }
    }
    
    func bind(viewModel : TitleTextFieldCellViewModel){
        self.titleInputField.rx.text
            .asSignal(onErrorJustReturn: nil)
            .emit(to: viewModel.titleText)
            .disposed(by: self.bag)
    }
}
