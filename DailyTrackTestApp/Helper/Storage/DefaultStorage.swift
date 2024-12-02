//
//  DefaultStorage.swift
//  AppStore
//
//  Created by Phùng Anh Đài  on 26/10/24.
//

import Foundation

private struct DefaultsStorageKeys {
  static let selectOfDay = "selectOfday"
  static let selectOfInterval = "selectOfInterval"
  static let timeOfDay = "timeOfDay"
  static let noFirstTimeLaunchKey = "noFirstTimeLaunchKey"
}

protocol UserDefaultsProvider {
  func set(_ value: Any?, forKey defaultName: String)
  func bool(forKey defaultName: String) -> Bool
  func double(forKey defaultName: String) -> Double
  func integer(forKey defaultName: String) -> Int
  func string(forKey defaultName: String) -> String?
  func date(forKey defaultName: String) -> Date?
  func arrInterger(forKey defaultName: String) -> [Int]?
}

extension UserDefaults: UserDefaultsProvider {
  func date(forKey defaultName: String) -> Date? {
    guard let date = value(forKey: defaultName) as? Date  else { return nil }
    return date
  }
  
  func arrInterger(forKey defaultName: String) -> [Int]? {
    guard let arrInt = value(forKey: defaultName) as? [Int]  else { return nil }
    return arrInt
  }
}

protocol DefaultsStorage {
    
  var noFirstTimeLaunch: Bool { get set }
  var selectOfDay: [Int] { get set }
  var selectOfInterval: [Int] { get set }
  var timeOfDay: [Int]? { get set }
}

class DefaultsStorageImpl: DefaultsStorage {
  
  // MARK: - Init
  
  init(userDefaultsProvider: UserDefaultsProvider = UserDefaults.standard) {
    defaults = userDefaultsProvider
  }
  
  // MARK: - Private Variables
  
  private let defaults: UserDefaultsProvider
  
  // MARK: - Public Variables
    
    
    
    var selectOfDay: [Int] {
        get {
            return defaults.arrInterger(forKey: DefaultsStorageKeys.selectOfDay) ?? []  // Trả về mảng trống nếu không có dữ liệu
        }
        set {
            defaults.set(newValue, forKey: DefaultsStorageKeys.selectOfDay)  // Lưu mảng vào UserDefaults
        }
    }
    
    var selectOfInterval: [Int] {
        get {
            return defaults.arrInterger(forKey: DefaultsStorageKeys.selectOfInterval) ?? []  // Trả về mảng trống nếu không có dữ liệu
        }
        set {
            defaults.set(newValue, forKey: DefaultsStorageKeys.selectOfInterval)  // Lưu mảng vào UserDefaults
        }
    }
    
    var timeOfDay: [Int]? {
        get {
            return defaults.arrInterger(forKey: DefaultsStorageKeys.timeOfDay)
        }
        set {
            defaults.set(newValue, forKey: DefaultsStorageKeys.timeOfDay)
        }
    }
    
  
  var noFirstTimeLaunch: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.noFirstTimeLaunchKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.noFirstTimeLaunchKey)
    }
  }
  
}
