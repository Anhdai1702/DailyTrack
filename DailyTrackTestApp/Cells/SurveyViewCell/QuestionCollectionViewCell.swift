//
//  QuestionCollectionViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 7/11/24.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    //MARK: - Constant
    static let defaultHeight : CGFloat = 88
    
    //MARK: - Outlets
    @IBOutlet private weak var questionsLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - Setup Methods
    private func setupView(){
        setupQuestionLabel()
    }
    
    private func setupQuestionLabel() {
        questionsLabel.font = .systemFont(ofSize: 16)
    }
    
    // MARK: - Configure
    func setupQuestion(with text: SurveyAnswerModel) {
        questionsLabel.text = text.answerDetail
        toggleAnswer(isChoose: text.isChoose)
    }
    
    func toggleAnswer(isChoose : Bool){
        self.backgroundColor = isChoose ? UIColor(resource: .serveyColorBlue) : UIColor(resource: .serveyColorClear)
    }
}
