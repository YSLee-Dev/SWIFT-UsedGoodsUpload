//
//  CategoryViewModel.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/10.
//

import Foundation

import RxSwift
import RxCocoa

struct CategoryViewModel {
    let bag = DisposeBag()
    
    // ViewModel > View
    let cellData : Driver<[Category]>
    let pop : Signal<Void>
    
    // View > ViewModel
    let itemSeleted = PublishRelay<Category>()
    
    // Out
    let outSelected : PublishRelay<Category>
    
    init(){
        let categories = [
            Category(id: 1, name: "디지털/가정"),
            Category(id: 2, name: "게임"),
            Category(id: 3, name: "스포츠/레저"),
            Category(id: 4, name: "가구"),
            Category(id: 5, name: "생활/식품"),
            Category(id: 6, name: "뷰티/미용"),
            Category(id: 7, name: "기타"),
        ]
        self.cellData = Driver.just(categories)
        
        self.pop = itemSeleted
            .map{ _ in
                Void()
            }
            .asSignal(onErrorSignalWith: .empty())
        
        self.outSelected = self.itemSeleted
    }
}
