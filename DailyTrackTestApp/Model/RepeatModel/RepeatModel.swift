//
//  RepeatModel.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 15/11/24.
//

import Foundation

struct RepeatModel: Equatable {
    var dayLabel: String
    
    // Implement the '==' operator for custom comparison if needed
       static func ==(lhs: RepeatModel, rhs: RepeatModel) -> Bool {
           return lhs.dayLabel == rhs.dayLabel
       }
}

struct MonthlyModel {
    var dayOfTheMonth: Int
}

struct SegmentModel {
    let title: String
    var isSelected: Bool = false
}
