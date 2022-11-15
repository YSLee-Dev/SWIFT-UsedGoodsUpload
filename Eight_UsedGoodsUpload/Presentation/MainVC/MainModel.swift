//
//  MainModel.swift
//  Eight_UsedGoodsUpload
//
//  Created by 이윤수 on 2022/11/15.
//

import Foundation

struct MainModel{
    func setAlert(errorMsg : [String]) -> Alert{
        let title = errorMsg.isEmpty ? "성공" : "실패"
        let msg = errorMsg.isEmpty ? nil : errorMsg.joined(separator: "\n")
        return (title: title, msg: msg)
    }
}
