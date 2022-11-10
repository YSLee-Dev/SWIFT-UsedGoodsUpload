//
//  DetailWirteFormCell.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift
import Then
import SnapKit

class DetailWirteFormCell : UITableViewCell{
    let bag = DisposeBag()
    let contentInputView = UITextView().then{
        $0.font = .systemFont(ofSize: 15)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailWirteFormCell{
    private func layout(){
        self.contentView.addSubview(self.contentInputView)
        self.contentInputView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(15)
            $0.height.equalTo(250)
        }
    }
    
    func bind(viewModel : DetailWirteFormViewModel){
        self.contentInputView.rx.text
            .bind(to: viewModel.contentValue)
            .disposed(by: self.bag)
    }
}
