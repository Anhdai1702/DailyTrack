//
//  SurveyQuestionCollectionViewCell.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 7/11/24.
//

import UIKit

protocol SurveyQuestionCellDelegate : AnyObject {
  func didSelectAnswer(_ view : SurveyQuestionCollectionViewCell,with answerIndex : Int)
}

class SurveyQuestionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet private weak var questionsLabel: UILabel!
    @IBOutlet private weak var titleImage: UIImageView!
    @IBOutlet private weak var surveyQuetionsCollectionView: UICollectionView!
    
    //MARK: - Variable
    private struct Constants {
      static let minimumLineSpacingForSection : CGFloat = 16
      static let minimumInteritemSpacingForSection : CGFloat = 16
    }
    private var answers : [SurveyAnswerModel] = []
    weak var delegate : SurveyQuestionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

//MARK: - Custom methods
extension SurveyQuestionCollectionViewCell {
    
    private func setupUI() {
        registerCell()
    }
    
    private func registerCell() {
        surveyQuetionsCollectionView.setup(cellType: QuestionCollectionViewCell.self, delegateAndDataSource: self)
    }
    
    func configure(with model : SurveyQuestionModel){
        questionsLabel.text = model.questionsLabel
      answers = model.answers.map({ answer in
        return SurveyAnswerModel(answerDetail: answer, isChoose: false)
      })
      if let selectedAnswer = model.selectedAnswer {
        answers[selectedAnswer].isChoose = true
      }
        titleImage.image = model.titleImage
        surveyQuetionsCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension SurveyQuestionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCollectionViewCell", for: indexPath) as? QuestionCollectionViewCell else {fatalError("Cannot dequeueReusableCell AnswerCell")}
        cell.setupQuestion(with: answers[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      delegate?.didSelectAnswer(self, with: indexPath.row)
      answers = answers.map({ answerModel in
        return SurveyAnswerModel.init(answerDetail: answerModel.answerDetail, isChoose: false)
      })
      answers[indexPath.row].isChoose = true
      collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SurveyQuestionCollectionViewCell : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Constants.minimumLineSpacingForSection
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    Constants.minimumInteritemSpacingForSection
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: QuestionCollectionViewCell.defaultHeight)
  }
}

