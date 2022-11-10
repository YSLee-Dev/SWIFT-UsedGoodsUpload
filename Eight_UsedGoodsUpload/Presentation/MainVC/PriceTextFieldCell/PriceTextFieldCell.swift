//
//  PriceTextFieldCell.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift
import Then
import SnapKit

class PriceTextFieldCell : UITableViewCell {
    let bag = DisposeBag()
    let priceInputField = UITextField().then{
        $0.font = .systemFont(ofSize: 15)
        $0.keyboardType = .numberPad
    }
    let freeShareBtn = UIButton().then{
        $0.setTitle("무료나눔", for: .normal)
        $0.setTitleColor(UIColor.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PriceTextFieldCell{
    private func layout(){
        [self.freeShareBtn, self.priceInputField]
            .forEach({self.contentView.addSubview($0)})
        
        self.priceInputField.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(15)
        }
        
        self.freeShareBtn.snp.makeConstraints{
            $0.leading.top.bottom.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
    }
    
    func bind(viewModel : PriceTextFieldViewModel){
        self.priceInputField.rx.text
            .bind(to: viewModel.priceValue)
            .disposed(by: self.bag)
        
        self.freeShareBtn.rx.tap
            .bind(to: viewModel.freeShareBtnClick)
            .disposed(by: self.bag)
        
        viewModel.resultPrice
            .map{ _ in
                ""
            }
            .emit(to: self.priceInputField.rx.text)
            .disposed(by: self.bag)
        
        viewModel.showFreeShareBtn
            .map{!$0}
            .emit(to: self.freeShareBtn.rx.isHidden)
            .disposed(by: self.bag)
    }
}
