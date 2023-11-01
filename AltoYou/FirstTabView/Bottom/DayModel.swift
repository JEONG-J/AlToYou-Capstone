//
//  DayModel.swift
//  AltoYou
//
//  Created by 정의찬 on 10/6/23.
//

import Foundation
import UIKit

public struct DayModel{
    let day: String
    let isCheck: Bool
}

final class cellInfor {
    static let DayList : [DayModel] = [
            DayModel(day: "월", isCheck: false),
            DayModel(day: "화", isCheck: true),
            DayModel(day: "수", isCheck: false),
            DayModel(day: "목", isCheck: false),
            DayModel(day: "금", isCheck: true),
            DayModel(day: "토", isCheck: false),
            DayModel(day: "일", isCheck: false)
    ]
}
