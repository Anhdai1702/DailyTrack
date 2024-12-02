//
//  CalendarView.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 25/11/24.
//

import UIKit
import FSCalendar

class CalendarView : NibView {
    // MARK: - Outlets
    @IBOutlet private weak var calendarView: UIView!
    
    // MARK: - Variables
    private let calendarFirstWeekDay : UInt = 2
    
    // MARK: - Life cycles
    override func configureView() {
        super.configureView()
        setupCalendar()
    }
    
    private lazy var calendar : FSCalendar = {
        let calendar = FSCalendar()
        calendarView.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.pinViewToEdgesOfSuperview(leftOffset: 0,rightOffset: 0,topOffset: 0,bottomOffset: 0)
        return calendar
    }()
    
    private func setupCalendar(){
        calendar.delegate = self
        calendar.dataSource = self
        calendar.headerHeight = 0
        calendar.firstWeekday = calendarFirstWeekDay
//        calendar.backgroundColor = .clear
        //MARK: - Color for Monday -> Sunday label
        calendar.calendarWeekdayView.weekdayLabels.forEach { label in
            label.textColor = UIColor(hex: "#8A8E9E")
            label.font = UIFont.systemFont(ofSize: 12)
        }
    }
    
}

//MARK: - FSCalendarDelegate
extension CalendarView : FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
}
//MARK: - FSCalendarDataSource
extension CalendarView : FSCalendarDataSource {
    
}
//MARK: -
extension CalendarView : FSCalendarDelegateAppearance {
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

