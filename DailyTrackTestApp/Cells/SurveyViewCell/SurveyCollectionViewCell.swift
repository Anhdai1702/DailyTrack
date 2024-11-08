//
//  SurveyCollectionViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 7/11/24.
//

import UIKit

class SurveyCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var skyDayImage: UIImageView!
    @IBOutlet private weak var backgrounDayImage: UIImageView!
    @IBOutlet private weak var skyNightImage: UIImageView!
    @IBOutlet private weak var backgroundNightImage: UIImageView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    //MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        setupQuestionLabel()
        setupDatePicker()
    }
    
    private func setupQuestionLabel() {
        questionLabel.font = .systemFont(ofSize: 20)
    }
    
    private func setupDatePicker() {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.locale = Locale(identifier: "en")
    }
    
    //MARK: - Configure
    func configure(text: SurveysleepAndWakeUpModel) {
        questionLabel.text = text.questionsLabel
    }
    
    func configureFirstCell(){
        skyDayImage.isHidden = false
        skyNightImage.isHidden = true
    }
    
    func configureSecondCell(){
        skyDayImage.isHidden = true
        skyNightImage.isHidden = false
    }
}
