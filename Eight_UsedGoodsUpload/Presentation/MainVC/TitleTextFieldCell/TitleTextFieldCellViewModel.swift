//
//  TitleTextFieldCellViewModel.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/10.
//

import Foundation

import RxSwift
import RxCocoa

struct TitleTextFieldCellViewModel{
    let titleText = PublishRelay<String?>()
}
