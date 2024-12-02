//
//  MenuViewController.swift
//  DailyTrackTestApp   
//
//  Created by Phùng Anh Đài  on 9/11/24.
//

import UIKit
import FSCalendar

class MenuViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    //MARK: - Variable
    
    private let timeManager = TimeManager.shared
    private var allCompleteDates : [Date] = []
    private var someCompleteDates : [Date] = []
    private var inProgressDates : [Date] = []
    private let calendarFirstWeekDay : UInt = 2
    private lazy var pieChart : ConnectedArcsView = {
        let chart = ConnectedArcsView()
        chart.backgroundColor = .clear
        chart.translatesAutoresizingMaskIntoConstraints = false
        chartContainerView.addSubview(chart)
        chart.pinViewToEdgesOfSuperview(leftOffset: 0,rightOffset: 0,topOffset: 0,bottomOffset: 0)
        return chart
    }()
    
    private lazy var calendar : FSCalendar = {
        let calendar = FSCalendar()
        calendarView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.pinViewToEdgesOfSuperview(leftOffset: 0,rightOffset: 0,topOffset: 0,bottomOffset: 0)
        return calendar
    }()
    
    //MARK: - Outlets
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var nameUserLabel: UILabel!
    @IBOutlet private weak var numberOfDaysLabel: UILabel!
    @IBOutlet private weak var habitTrackerLabel: UILabel!
    @IBOutlet private weak var chartContainerView: UIView!
    @IBOutlet private weak var guessInfoView: UIView!
    @IBOutlet private weak var inprogressLabel: UILabel!
    @IBOutlet private weak var inprogressPercentLabel: UILabel!
    @IBOutlet private weak var completedLabel: UILabel!
    @IBOutlet private weak var completePercentLabel: UILabel!
    @IBOutlet private weak var failedLabel: UILabel!
    @IBOutlet private weak var failedPercentLabel: UILabel!
    @IBOutlet private weak var calendarInProgressLabel: UILabel!
    @IBOutlet private weak var calendarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Actions
extension MenuViewController {
    
    @IBAction func didTapSetting(_ sender: Any) {
    }
    
    @IBAction func didTapDetail(_ sender: Any) {
    }
    
    @IBAction func navigatePreviousMontTapped(_ sender: Any) {
        let currentDate = calendar.currentPage
        
        // Get the previous month's date
        if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
            // Set the calendar to the previous month
            calendar.setCurrentPage(previousMonth, animated: true)
        }
        updateCurrentMonthLabel()
    }
    
    @IBAction func navigateNextMonthTapped(_ sender: Any) {
        let currentDate = calendar.currentPage
        
        // Get the previous month's date
        if let previousMonth = Calendar.current.date(byAdding: .month, value: +1, to: currentDate) {
            // Set the calendar to the previous month
            calendar.setCurrentPage(previousMonth, animated: true)
        }
        updateCurrentMonthLabel()
    }
}

//MARK: - Custom Methods
extension MenuViewController {
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupCalendar()
        updateCurrentMonthLabel()
    }
    
    private func setupCalendar(){
        calendar.delegate = self
        calendar.dataSource = self
        calendar.headerHeight = 0
        calendar.firstWeekday = calendarFirstWeekDay
        calendar.backgroundColor = .clear
        //MARK: - Color for Monday -> Sunday label
        calendar.calendarWeekdayView.weekdayLabels.forEach { label in
            label.textColor = UIColor(hex: "#8A8E9E")
            label.font = UIFont.systemFont(ofSize: 12)
        }
    }
    private func updateCurrentMonthLabel(){
        let currentMonth = Calendar.current.component(.month, from: calendar.currentPage)
        let currentYear = Calendar.current.component(.year, from: calendar.currentPage)
        let monthString : String = timeManager.monthNameLocalized(from: currentMonth) ?? ""
        
        let redString = monthString + " "
        let whiteString = "\(currentYear)"
        
        // Create attributes for the strings
        let redAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(resource: .calendarDatePinkAttribute)
        ]
        
        let whiteAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        
        // Create attributed strings
        let redAttributedString = NSAttributedString(string: redString, attributes: redAttributes)
        let whiteAttributedString = NSAttributedString(string: whiteString, attributes: whiteAttributes)
        
        // Combine the attributed strings into one mutable attributed string
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(redAttributedString)
        combinedAttributedString.append(whiteAttributedString)
        
        // Set the label's attributed text
        calendarInProgressLabel.attributedText = combinedAttributedString
    }
}

//MARK: - FSCalendarDelegate
extension HomeViewController : FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
}
//MARK: - FSCalendarDataSource
extension HomeViewController : FSCalendarDataSource {
    
}
//MARK: -
extension HomeViewController : FSCalendarDelegateAppearance {
    //MARK: - Set color for day in current/other month
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let dateMonth = calendar.component(.month, from: date)
        // Check if the date is in the current month
        if currentMonth == dateMonth {
            return UIColor.white // Color for days in the current month
        } else {
            return UIColor.clear/*UIColor(resource: .calendarDayOtherMonth)*/ // Color for days in other months
        }
    }
}

