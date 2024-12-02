//
//  TimeManager.swift
//  Shiftdays
//
//  Created by Vu Minh Hieu on 04/09/2024.
//

import Foundation

class TimeManager {
  
  // Shared instance of TimeManager (Singleton)
  static let shared = TimeManager()
  
  // Private initializer to prevent instantiation from outside
  private init() {
    // Initialization code
  }
  
  // Output: "08:00 - 23:59"
  func formatTimeRange(startHour: Int, startMinute: Int, endHour: Int, endMinute: Int) -> String? {
      // Ensure that the hour and minute values are valid
      guard (0...23).contains(startHour), (0...59).contains(startMinute),
            (0...23).contains(endHour), (0...59).contains(endMinute) else {
          return nil
      }
      
      // Format the hours and minutes to always have two digits for minutes
      let startTime = String(format: "%02d:%02d", startHour, startMinute)
      let endTime = String(format: "%02d:%02d", endHour, endMinute)
      
      // Combine the start and end times into the desired format
      let timeRange = "\(startTime) - \(endTime)"
      
      return timeRange
  }

  
  func isLegitTimeRange(startTime: Date, endTime: Date, breakTime: Date, breakDuration: TimeInterval) -> Bool {
    
    // Check if start time is before end time
    guard startTime < endTime else {
      return false
    }
    
    //duration = 0 && start time before end time => passed
    if breakDuration == 0 {
      return true
    }
    
    // Check if break time is within the range of start time and end time
    guard breakTime >= startTime && breakTime < endTime else {
      return false
    }
    
    // Check if the break duration fits within the available time after break time and before end time
    let breakEndTime = breakTime.addingTimeInterval(breakDuration)
    guard breakEndTime <= endTime else {
      return false
    }
    // All checks passed, the time range is legit
    return true
  }
  
  func getHourAndMinute(from date: Date) -> (hour: Int, minute: Int)? {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: date)
    
    guard let hour = components.hour, let minute = components.minute else {
      return nil
    }
    
    return (hour, minute)
  }
  
  func timeIntervalFromMidnight(from date: Date) -> TimeInterval? {
    guard let timeComponents = getHourAndMinute(from: date) else {
      return nil
    }
    
    let hour = timeComponents.hour
    let minute = timeComponents.minute
    
    // Calculate the total seconds from midnight
    let secondsFromMidnight = (hour * 3600) + (minute * 60)
    
    return TimeInterval(secondsFromMidnight)
  }
  
  func combineToDate(hour: Int, minute: Int) -> Date? {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current
    
    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    
    return calendar.date(from: components)
  }
  
  func formatTimeInterval(from date: Date) -> String {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: date)
    
    guard let hours = components.hour, let minutes = components.minute else {
      return ""
    }
    
    var timeString = ""
    
    if hours > 0 {
      timeString += "\(hours) " + "hour" + "\(hours > 1 ? "s-many" : "")"
    }
    
    if minutes > 0 {
      if !timeString.isEmpty {
        timeString += " "
      }
      timeString += "\(minutes) " +  "minute" + "\(minutes > 1 ? "s-many" : "")"
    }
    if hours == 0 && minutes == 0 {
      return "break-time-0-minute"
    }
    return timeString
  }
  
   func minutesFromStartOfDay(hour: Int, minute: Int) -> Int {
      return hour * 60 + minute
  }

  
  func changeToCurrentTimeZone(dates : [Date]) -> [Date] {
    var resultDates : [Date] = []
    for date in dates {
      let timeZone = TimeZone.current
      let calendar = Calendar.current
      guard let resultDate : Date = calendar.dateComponents(in: timeZone, from: date).date else {return []}
      resultDates.append(resultDate)
    }
    return resultDates
  }
  
  func formatDateToDayMonthYear(date: Date) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      return dateFormatter.string(from: date)
  }
  
  func monthNameLocalized(from month: Int) -> String? {
      let monthNames = [
        1: "January", 2: "February", 3: "March", 4: "April", 5: "May", 6: "June",
          7: "July", 8: "August", 9: "September", 10: "October", 11: "November", 12: "December"
      ]
      
      return monthNames[month]
  }

  func createDateArray(from startDate: Date, to endDate: Date) -> [Date] {
      var dates: [Date] = []
      var currentDate = startDate

      let calendar = Calendar.current

      while currentDate <= endDate {
          dates.append(currentDate)
          if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
              currentDate = nextDate
          }
      }
      return dates
  }
}
