//
//  SurveyModel.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 7/11/24.
//

import Foundation
import UIKit

struct SurveysleepAndWakeUpModel {
    var questionsLabel: String
}

struct SurveyQuestionModel {
    var questionsLabel: String
    var titleImage: UIImage
    var answers : [String]
    var selectedAnswer : Int?
}

struct SurveyAnswerModel {
  var answerDetail : String
  var isChoose : Bool
}


