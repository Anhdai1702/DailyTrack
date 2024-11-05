//
//  DefaultStorage.swift
//  AppStore
//
//  Created by Phùng Anh Đài  on 26/10/24.
//

import Foundation

private struct DefaultsStorageKeys {
  static let noFirstTimeLaunchKey = "NoFirstTimeLaunchKey"
  static let dbVersionKey = "DBVersionKey"
  static let pointKey = "PointKey"
  static let rankKey = "RankKey"
  static let currentLanguageKey = "CurrentLanguageKey"
  static let numberOfWinKey = "NumberOfWinKey"
  static let currentLevelKey = "CurrentLevelKey"
  static let didLanguageSetupKey = "DidLanguageSetupKey"
  static let selectedAdDayKey = "SelectedAdDayKey"
  static let adsActionKey = "AdsAction"
  static let sgkDBVersionKey = "SgkDBVersionKey"
  static let zoomGuideTooltipDidShowKey = "ZoomGuideTooltipDidShowKey"
  static let savedPagesKey = "SavedPagesKey"
  static let savedPages2Key = "SavedPages2Key"
  static let isMorningReMindEnableKey = "isMorningReMindEnableKey"
  static let isNoonReMindEnableKey = "isNoonReMindEnableKey"
  static let isEveningReMindEnableKey = "isEveningReMindEnableKey"
  static let isSetupNotiCompletedKey = "isSetupNotiCompletedKey"
  static let morningTimeKey = "morningTimeKey"
  static let noonTimeKey = "noonTimeKey"
  static let eveningTimeKey = "eveningTimeKey"
  static let eveningMinuteTimeKey = "eveningMinuteTimeKey"
  static let noonMinuteTimeKey = "noonMinuteTimeKey"
  static let morningMinuteTimeKey = "morningMinuteTimeKey"
  static let soundKey = "SoundKey"
  static let ckCurrentLevel = "CkCurrentLevel"
  static let currentCkDBVersion = "currentCkDBVersion"
  static let isMixpanelIdentifySetuped = "isMixpanelIdentifySetuped"
  static let challengeAwardTurn = "challengeAwardTurn"
  static let isInReview = "isInReview"
  static let aYearPrice = "aYearPrice"
  static let threeMonthsPrice = "threeMonthsPrice"
  static let aMonthPrice = "aMonthPrice"
  static let fullMonthsPrice = "fullMonthsPrice"
  static let preferredCurrencyKey = "PreferredCurrencyKey"
  static let currentBalance = "initBalance"
  static let changeIcon = "changeIcon"
  static let completeSetupColors = "completeSetupColors"
  static let nameColorLabelKey = "NameColorLabelKey"
  static let isShowPassCode = "isShowPassCode"
  static let appPassCode = "AppPasscode"
  static let previousAdFullType = "previousAdFullType"
  static let latestTimeAdShown = "latestTimeAdShown"
  static let isRemindNotification = "isRemindNotification"
  static let notificationHour = "notificationHour"
  static let notificationMinute = "notificationMinute"
  static let isSwitchSyncIcloud = "isSwitchSyncIcloud"
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
//  var isMixpanelIdentifySetuped: Bool { get set }
//  var stopAdFeatureEnabled: Bool { get set }
  var noFirstTimeLaunch: Bool { get set }
  var dbVersion: Int { get set }
  var point: Int { get set }
  var rank: String { get set }
  var currentLanguage: String { get set }
  var numberOfWin: Int { get set }
  var currentLevel: Int { get set }
  var didLanguageSetup: Bool { get set }
  var adsAction: Int { get set }
  var selectedAdDay: String { get set }
  var zoomGuideTooltipDidShow: Bool { get set }
  var savedPages: [Int]? { get set }
  var savedPages2: [Int]? { get set }
  var isMorningReMindEnable: Bool { get set }
  var isNoonReMindEnable: Bool { get set }
  var isEveningReMindEnable: Bool { get set }
  var isSetupNotiCompleted: Bool { get set }
  var morningTime: Int { get set }
  var noonTime: Int { get set }
  var eveningTime: Int { get set }
  var morningMinuteTime: Int { get set }
  var noonMinuteTime: Int { get set }
  var eveningMinuteTime: Int { get set }
  var isSoundOn: Bool { get set }
  var ckCurrentLevel: Int { get set }
  var currentCkDBVersion: Int { get set }
  var isInReview: Bool { get set }
  var aYearPrice: String? { get set }
  var threeMonthsPrice: String? { get set }
  var aMonthPrice: String? { get set }
  var fullMonthsPrice: String? { get set }
  var changeIcon: Int? { get set }
  var completeSetupColors: String? { get set}
  var nameColorLabelKey: String? {get set}
  var isShowPassCode: Bool { get set }
  var isRemindNotification: Bool { get set }
  var appPassCode: String? { get set }
  var previousAdFullType: Int { get set }
  var latestTimeAdShown: Date? { get set }
  
  var notificationHour: Int? { get set }
  var notificationMinute: Int? { get set }
  
  func setChallengeAwardTurn(userId: String, battleId: Int, turn: Int)
  func getChallengeAwardTurn(userId: String, battleId: Int) -> Int
  
  var currentMoney: String { get set }
  var currentBalance: Double { get set }
  var isSwitchSyncIcloud: Bool { get set }
}

class DefaultsStorageImpl: DefaultsStorage {
  
  // MARK: - Init
  
  init(userDefaultsProvider: UserDefaultsProvider = UserDefaults.standard) {
    defaults = userDefaultsProvider
  }
  
  // MARK: - Private Variables
  
  private let defaults: UserDefaultsProvider
  
  // MARK: - Public Variables
    
    
  var latestTimeAdShown: Date? {
    get {
        return defaults.date(forKey: DefaultsStorageKeys.latestTimeAdShown)
    }
    set {
        defaults.set(newValue, forKey: DefaultsStorageKeys.latestTimeAdShown)
    }
  }
    
  var previousAdFullType: Int {
    get {
        return defaults.integer(forKey: DefaultsStorageKeys.previousAdFullType)
    }
    set {
        defaults.set(newValue, forKey: DefaultsStorageKeys.previousAdFullType)
    }
  }
    
  var changeIcon: Int? {
    get {
        return defaults.integer(forKey: DefaultsStorageKeys.changeIcon)
    }
    set {
        defaults.set(newValue, forKey: DefaultsStorageKeys.changeIcon)
    }
  }
    
  var completeSetupColors: String? {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.completeSetupColors)
    }
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.completeSetupColors)
    }
  }
        
  var nameColorLabelKey: String? {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.nameColorLabelKey)
    }
      set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.nameColorLabelKey)
    }
  }
    
  var aYearPrice: String? {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.aYearPrice)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.aYearPrice)
    }
  }
  
  var fullMonthsPrice: String? {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.fullMonthsPrice)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.fullMonthsPrice)
    }
  }
  
  var threeMonthsPrice: String? {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.threeMonthsPrice)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.threeMonthsPrice)
    }
  }
  
  var aMonthPrice: String? {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.aMonthPrice)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.aMonthPrice)
    }
  }
  
  
  var isInReview: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isInReview)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isInReview)
    }
  }
  
  var currentCkDBVersion: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.currentCkDBVersion)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.currentCkDBVersion)
    }
  }
  
  var ckCurrentLevel: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.ckCurrentLevel)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.ckCurrentLevel)
    }
  }
  
  var isMixpanelIdentifySetuped: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isMixpanelIdentifySetuped)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isMixpanelIdentifySetuped)
    }
  }
  var isSoundOn: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.soundKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.soundKey)
    }
  }
  
  var morningMinuteTime: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.morningMinuteTimeKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.morningMinuteTimeKey)
    }
  }
  
  var noonMinuteTime: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.noonMinuteTimeKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.noonMinuteTimeKey)
    }
  }
  
  var eveningMinuteTime: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.eveningMinuteTimeKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.eveningMinuteTimeKey)
    }
  }
  
  var morningTime: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.morningTimeKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.morningTimeKey)
    }
  }
  
  var noonTime: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.noonTimeKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.noonTimeKey)
    }
  }
  
  var eveningTime: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.eveningTimeKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.eveningTimeKey)
    }
  }
  
  var isMorningReMindEnable: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isMorningReMindEnableKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isMorningReMindEnableKey)
    }
  }
  
  var isNoonReMindEnable: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isNoonReMindEnableKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isNoonReMindEnableKey)
    }
  }
  
  var isEveningReMindEnable: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isEveningReMindEnableKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isEveningReMindEnableKey)
    }
  }
  
  var isSetupNotiCompleted: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isSetupNotiCompletedKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isSetupNotiCompletedKey)
    }
  }
  
  var adsAction: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.adsActionKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.adsActionKey)
    }
  }
  
  var savedPages: [Int]? {
    get {
      return defaults.arrInterger(forKey: DefaultsStorageKeys.savedPagesKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.savedPagesKey)
    }
  }
  
  var savedPages2: [Int]? {
    get {
      return defaults.arrInterger(forKey: DefaultsStorageKeys.savedPages2Key)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.savedPages2Key)
    }
  }
  
  var selectedAdDay: String {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.selectedAdDayKey) ?? ""
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.selectedAdDayKey)
    }
  }
  
  var zoomGuideTooltipDidShow: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.zoomGuideTooltipDidShowKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.zoomGuideTooltipDidShowKey)
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
  
  var dbVersion: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.dbVersionKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.dbVersionKey)
    }
  }
  
  var point: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.pointKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.pointKey)
    }
  }
  
  var rank: String {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.rankKey) ?? "Bronze"
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.rankKey)
    }
  }
  
  var currentLanguage: String {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.currentLanguageKey) ?? "en"
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.currentLanguageKey)
    }
  }
  
  var numberOfWin: Int {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.numberOfWinKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.numberOfWinKey)
    }
  }
  
  var currentLevel: Int {
    get {
      return defaults
        .integer(forKey: DefaultsStorageKeys.currentLevelKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.currentLevelKey)
    }
  }
  
  var didLanguageSetup: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.didLanguageSetupKey)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.didLanguageSetupKey)
    }
  }
  
//  func setCoin(_ coin: Double) {
//    let key = DefaultsStorageKeys.coinKey
//    defaults.set(coin, forKey: key)
//  }
//  
//  func getCoin() -> Double {
//    let key = DefaultsStorageKeys.coinKey
//    return defaults.double(forKey: key)
//  }
  
  func setChallengeAwardTurn(userId: String, battleId: Int, turn: Int) {
    let key = String(format: DefaultsStorageKeys.challengeAwardTurn, userId, String(battleId))
    defaults.set(turn, forKey: key)
  }
  
  func getChallengeAwardTurn(userId: String, battleId: Int) -> Int {
    let key = String(format: DefaultsStorageKeys.challengeAwardTurn, userId, String(battleId))
    return defaults.integer(forKey: key)
  }
  
  var currentMoney: String {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.preferredCurrencyKey) ?? getCurrencyBasedOnLanguage()
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.preferredCurrencyKey)
    }
  }
  
  var currentBalance: Double {
    get {
      return defaults.double(forKey: DefaultsStorageKeys.currentBalance)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.currentBalance)
    }
  }
  
  private func getCurrencyBasedOnLanguage() -> String {
    switch currentLanguage {
    case "vi":
      return "VND"
    case "en":
      return "USD"
      // add case if needed
    default:
      return "USD"
    }
  }
  
  var isShowPassCode: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isShowPassCode)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isShowPassCode)
    }
  }
  
  var isRemindNotification: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isRemindNotification)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isRemindNotification)
    }
  }
  
  var appPassCode: String? {
    get {
      return defaults.string(forKey: DefaultsStorageKeys.preferredCurrencyKey) ?? ""
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.preferredCurrencyKey)
    }
  }
  
  var notificationHour: Int? {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.notificationHour)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.notificationHour)
    }
  }
  
  var notificationMinute: Int? {
    get {
      return defaults.integer(forKey: DefaultsStorageKeys.notificationMinute)
    }
    
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.notificationMinute)
    }
  }
  
  var isSwitchSyncIcloud: Bool {
    get {
      return defaults.bool(forKey: DefaultsStorageKeys.isSwitchSyncIcloud)
    }
    set {
      defaults.set(newValue, forKey: DefaultsStorageKeys.isSwitchSyncIcloud)
    }
  }
  
  func setupInitialCurrencyIfNeeded() {
    if defaults.string(forKey: DefaultsStorageKeys.preferredCurrencyKey) == nil {
      currentMoney = getCurrencyBasedOnLanguage()
    }
  }
  
  func set(_ value: Bool, forKey key: String) {
    defaults.set(value, forKey: key)
  }
}
