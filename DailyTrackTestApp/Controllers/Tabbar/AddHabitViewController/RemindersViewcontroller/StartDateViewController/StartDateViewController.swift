//
//  StartDateViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 28/11/24.
//

import UIKit
import FSCalendar

class StartDateViewController: UIViewController {
    
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var customView: UIView!
    @IBOutlet private weak var closeBtn: UIButton!
    @IBOutlet private weak var startDateItems: UIView!
    @IBOutlet private weak var calendarInProgressLabel: UILabel!
    @IBOutlet private weak var calendarView: UIView!
    
    private let timeManager = TimeManager.shared
    private var allCompleteDates : [Date] = []
    private var someCompleteDates : [Date] = []
    private var inProgressDates : [Date] = []
    private let calendarFirstWeekDay : UInt = 2
    
    private lazy var calendar : FSCalendar = {
        let calendar = FSCalendar()
        calendarView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.pinViewToEdgesOfSuperview(leftOffset: 0,rightOffset: 0,topOffset: 0,bottomOffset: 0)
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Actions
extension StartDateViewController {
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true)
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

// MARK: - Custom methods
extension StartDateViewController {
    
    private func setupUI() {
        updateCurrentMonthLabel()
        setupCalendar()
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
extension StartDateViewController : FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
}
//MARK: - FSCalendarDataSource
extension StartDateViewController : FSCalendarDataSource {
    
}
//MARK: -
extension StartDateViewController : FSCalendarDelegateAppearance {
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
