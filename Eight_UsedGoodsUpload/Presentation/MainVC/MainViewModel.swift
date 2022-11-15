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
    
    // VIEWMODEL -> VIEW
    let cellData : Driver<[String]>
    let presentAlert : Observable<Alert>
    let push : Driver<CategoryViewModel>
    
    // VIEW -> VIEWMODEL
    let itemClick = PublishRelay<Int>()
    let submitBtnClick = PublishRelay<Void>()
    
    init(model : MainModel = .init()){
        let title = Observable.just("글 제목")
        let categoryViewModel = CategoryViewModel()
        let category = categoryViewModel
            .itemSeleted
            .map{
                $0.name
            }
            .startWith("카테고리 선택")
        let price = Observable.of("가격(선택)")
        let detail = Observable.of("내용을 입력하세요.")
        
        self.cellData = Observable
            .combineLatest(title, category, price, detail){ [$0, $1, $2, $3] }
            .asDriver(onErrorDriveWith: .empty())
        
        let titleMsg = titleTextFieldViewModel
            .titleText
            .map{
                $0?.isEmpty ?? true
            }
            .startWith(true)
            .map{
                $0 ? ["글 제목을 입력해주세요."] : []
            }
        
        let categoryMsg = categoryViewModel
            .itemSeleted
            .map{ _ in
                false
            }
            .startWith(true)
            .map{
                $0 ? ["카테고리를 선택해주세요."] : []
            }
        
        let detailMsg = detailWirteFormViewModel
            .contentValue
            .map{
                $0?.isEmpty ?? true
            }
            .startWith(true)
            .map{
                $0 ? ["내용을 입력해주세요."] : []
            }
        
        let errorMsg = Observable
            .combineLatest(titleMsg, categoryMsg, detailMsg){$0 + $1 + $2}
        
        self.presentAlert = submitBtnClick
            .withLatestFrom(errorMsg) { $1 }
            .map(model.setAlert)
        
        self.push = itemClick
            .compactMap{ row -> CategoryViewModel? in
                guard case 1 = row else{
                    return nil
                }
                return categoryViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
