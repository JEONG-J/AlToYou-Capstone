//
//  ChartDataModel.swift
//  AltoYou
//
//  Created by 정의찬 on 11/25/23.
//

import Foundation

struct ChartData {
    var value: Double
    var label: String
}

let evaluationPieChartData = [
    ChartData(value: 25, label: "평균 정확도"),
    ChartData(value: 80, label: "평균 유창성"),
    ChartData(value: 100, label: "평균 발음 완전성"),
    ChartData(value: 92, label: "평균 운율"),
    ChartData(value: 60, label: "평균 발음 품질")
]
