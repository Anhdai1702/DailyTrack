//
//  SurveyViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 7/11/24.
//

import UIKit

class SurveyViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var surveyCollectionView: UICollectionView!
    @IBOutlet private weak var continueBtn: UIButton!
    
    //MARK: - Variable
    private var currentPage : Int = 0 {
      didSet {
        if currentPage == 0 || currentPage == 1 {
            continueBtn.isHidden = false
        } else {
            continueBtn.isHidden = true
        }
      }
    }
    
    private let listQuestionSureySleepAndWakeUp =
    [
    SurveysleepAndWakeUpModel(questionsLabel: "What time do you sually wake up?"),
    SurveysleepAndWakeUpModel(questionsLabel: "When do you want reflect on your day?")
    ]
    
    private var listSurveyQuestion =
    [
    SurveyQuestionModel(questionsLabel: "Do you procrastinateon your work?", titleImage: UIImage(resource: .serveyIllust1), answers:
        [
        "Yes, I’m ready to change that",
        "No, I easily finish the tasks at hand",
        "Not ready to answer"
        ], selectedAnswer: nil),
    SurveyQuestionModel(questionsLabel: "Do you find it hard to focus?", titleImage: UIImage(resource: .serveyIllust2), answers:
        [
        "Yes, I’m get distracted easily",
        "No, I stay focused when needed",
        "Not ready to answer"
        ], selectedAnswer: nil),
    SurveyQuestionModel(questionsLabel: "What do you hope to achieve with DailyTrack?", titleImage: UIImage(resource: .serveyIllust3), answers:
        [
        "I want to build good habits",
        "I want to be organized",
        "Not ready to answer"
        ], selectedAnswer: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Actions
extension SurveyViewController {
    
    @IBAction func didTapBack(_ sender: Any) {
        if currentPage > 0 {
            currentPage -= 1
        } else {
            // If already in the first part, return to the previous screen
            self.navigationController?.popViewController(animated: true)
        }
        moveToItem(at: IndexPath(item: currentPage, section: 0))
    }
    
    @IBAction func didTapContinue(_ sender: Any) {
        moveToNextPage()
    }
}

//MARK: - Custom methods
extension SurveyViewController {
    
    private func setupUI() {
        registerCells()
        setupText()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func moveToNextPage() {
        let totalQuestions = listQuestionSureySleepAndWakeUp.count + listSurveyQuestion.count
        if currentPage < totalQuestions - 1 {
            currentPage += 1
            moveToItem(at: IndexPath(item: currentPage, section: 0))
        }
        else {
            moveToNextScreen(with: HomeViewController())
        }
    }
    
    private func moveToNextScreen(with Screen: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let vc = Screen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func registerCells() {
        surveyCollectionView.setup(cellType: SurveyCollectionViewCell.self, delegateAndDataSource: self)
        surveyCollectionView.setup(cellType: SurveyQuestionCollectionViewCell.self, delegateAndDataSource: self)
    }
    
    private func moveToItem(at indexPath: IndexPath) {
        surveyCollectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
        currentPage = indexPath.item
    }
    
    private func setupText() {
        continueBtn.setTitle("Continue", for: .normal)
        continueBtn.titleLabel?.font = .systemFont(ofSize: 14)
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension SurveyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listQuestionSureySleepAndWakeUp.count + listSurveyQuestion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0...1 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SurveyCollectionViewCell", for: indexPath) as? SurveyCollectionViewCell else {fatalError("Cannot dequeueReusableCell")}
            cell.configure(text: listQuestionSureySleepAndWakeUp[indexPath.row])
            if indexPath.row == 0 {
                cell.configureFirstCell()
            } else {
                cell.configureSecondCell()
            }
            return cell
        default :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SurveyQuestionCollectionViewCell", for: indexPath) as? SurveyQuestionCollectionViewCell else {fatalError("Cannot dequeueReusableCell")}
            cell.configure(with: listSurveyQuestion[indexPath.row - listQuestionSureySleepAndWakeUp.count])
            cell.delegate = self
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SurveyViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - SurveyQuestionCellDelegate
extension SurveyViewController: SurveyQuestionCellDelegate {
    func didSelectAnswer(_ view: SurveyQuestionCollectionViewCell, with answerIndex: Int) {
        // Get all displayed cells
        guard let visibleCells = surveyCollectionView.visibleCells as? [SurveyQuestionCollectionViewCell],
              let visibleCell = visibleCells.first(where: { $0 == view }) else { return }
        // Find the position of the cell in the survey question list
        guard let visiblePageIndex = surveyCollectionView.indexPath(for: visibleCell)?.row else { return }
        let habitIndex = visiblePageIndex - listQuestionSureySleepAndWakeUp.count
        listSurveyQuestion[habitIndex].selectedAnswer = answerIndex
        moveToNextPage()
    }
}

