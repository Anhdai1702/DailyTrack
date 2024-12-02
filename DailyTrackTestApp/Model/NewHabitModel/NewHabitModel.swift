//
//  NewHabitModel.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 13/11/24.
//

import Foundation
import UIKit

struct NewHabitModel {
    var titleNewHabit: String
    var newHabitImage: UIImage
}

struct CreateNewHabitModel {
    var themePhotoImage: UIImage?
    var titleLabel: String
    var periodOfTimeLabel: String
    var viewColor: UIColor
}


enum CreateNewHabit: CaseIterable {
    case setupNewHabit
    case startDate
    
    var item: [CreateNewHabitModel] {
        switch self {
        case .setupNewHabit:
            [
                CreateNewHabitModel(themePhotoImage: .createNewHabitRepeat, titleLabel: "Repeat", periodOfTimeLabel: "Everyday", viewColor: Constants.color355BE1),
                CreateNewHabitModel(themePhotoImage: .createNewHabitGoal, titleLabel: "Goal", periodOfTimeLabel: "1 time per day", viewColor: Constants.colorED0B4F),
                CreateNewHabitModel(themePhotoImage: .createNewHabitTimeOfDay, titleLabel: "Time of day", periodOfTimeLabel: "Any time", viewColor: Constants.colorF2BA03)
            ]
        case .startDate:
            [
                CreateNewHabitModel(themePhotoImage: .createNewHabitDate, titleLabel: "Start Date", periodOfTimeLabel: "Today: 15/11/2024", viewColor: Constants.color1640D6)
            ]
        }
    }
}
