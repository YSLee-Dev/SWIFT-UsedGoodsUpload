//
//  MainViewModel.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/08.
//

import Foundation

import RxSwift
import RxCocoa

struct MainViewModel{
    let titleTextFieldViewModel = TitleTextFieldCellViewModel()
    let priceTextFieldViewModel = PriceTextFieldViewModel()
    let detailWirteFormViewModel = DetailWirteFormViewModel()
}
