//
//  PriceTextFieldViewModel.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/10.
//

import Foundation

import RxSwift
import RxCocoa

struct PriceTextFieldViewModel{
    // ViewModel > View
    let showFreeShareBtn : Signal<Bool>
    let resultPrice : Signal<Void>
    
    // View > ViewModel
    let priceValue = PublishRelay<String?>()
    let freeShareBtnClick = PublishRelay<Void>()
    
    init(){
        self.showFreeShareBtn = Observable
            .merge(
                self.priceValue.map{$0 ?? "" == "0"},
                self.freeShareBtnClick.map{_ in false}
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resultPrice = freeShareBtnClick
            .asSignal(onErrorSignalWith: .empty())
    }
}
