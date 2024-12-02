import UIKit

class RepeatViewViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var blurUIView: UIView!
    @IBOutlet private weak var customView: UIView!
    @IBOutlet private weak var closeBtn: UIButton!
    @IBOutlet private weak var repeatTableView: UITableView!
    @IBOutlet private weak var calendarView: CalendarView!
    @IBOutlet private weak var segmentCustomView: SegmentCustomView!
    @IBOutlet private weak var backgroundBtnSave: UIButton!
    @IBOutlet private weak var updateDaysLabel: UILabel!
    @IBOutlet private weak var repeatView: UIView!
    
    // MARK: - Variables
    private var defaultStorage = DefaultsStorageImpl()
    private var listRepeat = [RepeatModel]()
    private var selectedDayIndices: Set<Int> = []
    private var selectedIntervalIndices: Set<Int> = []
    
    private let listDay = [
        RepeatModel(dayLabel: "Monday"), RepeatModel(dayLabel: "Tuesday"),
        RepeatModel(dayLabel: "Wednesday"), RepeatModel(dayLabel: "Thursday"),
        RepeatModel(dayLabel: "Friday"), RepeatModel(dayLabel: "Saturday"),
        RepeatModel(dayLabel: "Sunday")
    ]
    
    private let listInterval = [
        RepeatModel(dayLabel: "Every 2 days"), RepeatModel(dayLabel: "Every 3 days"),
        RepeatModel(dayLabel: "Every 4 days"), RepeatModel(dayLabel: "Every 5 days"),
        RepeatModel(dayLabel: "Every 6 days"), RepeatModel(dayLabel: "Every 7 days"),
        RepeatModel(dayLabel: "Every 8 days")
    ]
    
    private var segmentItems = [
        SegmentModel(title: "Daily", isSelected: true),
        SegmentModel(title: "Monthly"),
        SegmentModel(title: "Interval")
    ]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        saveSelection()
    }
    
    // MARK: - Custom methods
    private func setupUI() {
        setupSegmentCustomView()
        setupView()
        registerCell()
        loadSavedSelection()
        updateDaysLabelText()
    }
    
    private func loadSavedSelection() {
        selectedDayIndices = Set(defaultStorage.selectOfDay)
        selectedIntervalIndices = Set(defaultStorage.selectOfInterval)
    }
    
    private func setupSegmentCustomView() {
        segmentCustomView.segmentItems = segmentItems
        segmentCustomView.segmentCustomDelegate = self
    }
    
    private func setupView() {
        listRepeat = listDay
        calendarView.isHidden = true
        repeatView.setCornerRadius(32, corners: [.topRight, .topLeft])
        repeatTableView.setCornerRadius(32, corners: [.bottomRight, .bottomLeft])
    }
    
    private func saveSelection() {
        defaultStorage.selectOfDay = Array(selectedDayIndices)
        defaultStorage.selectOfInterval = Array(selectedIntervalIndices)
    }
    
    private func registerCell() {
        repeatTableView.setup(cellType: RepeatTableViewCell.self, delegateAndDataSource: self)
    }
    
    private func updateDaysLabelText() {
        if listRepeat == listDay {
            if selectedDayIndices.isEmpty {
                updateDaysLabel.text = "Everyday"
            } else if selectedDayIndices.count == listDay.count {
                updateDaysLabel.text = "No day selected"
            } else {
                let selectedDays = selectedDayIndices.sorted().map { listDay[$0].dayLabel }
                updateDaysLabel.text = selectedDays.joined(separator: ", ")
            }
        } else if listRepeat == listInterval {
            if selectedIntervalIndices.isEmpty {
                updateDaysLabel.text = "Everyday"
            } else {
                let selectedIntervals = selectedIntervalIndices.sorted().map { listInterval[$0].dayLabel }
                updateDaysLabel.text = selectedIntervals.joined(separator: ", ")
            }
        }
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RepeatViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRepeat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepeatTableViewCell", for: indexPath) as? RepeatTableViewCell else {
            return UITableViewCell()
        }
        
        let isSelected = (listRepeat == listDay) ? selectedDayIndices.contains(indexPath.row) : selectedIntervalIndices.contains(indexPath.row)
        cell.configureRepeat(model: listRepeat[indexPath.row])
        cell.toggleSelection(isSelected: !isSelected)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backgroundBtnSave.backgroundColor = Constants.color0F26C2
        
        // Check if we are dealing with listDay or listInterval and update the selection accordingly
        if listRepeat == listDay {
            if selectedDayIndices.contains(indexPath.row) {
                selectedDayIndices.remove(indexPath.row) // Remove the day if already selected
            } else {
                selectedDayIndices.insert(indexPath.row) // Add the day if not selected
            }
        } else {
            if selectedIntervalIndices.contains(indexPath.row) {
                selectedIntervalIndices.remove(indexPath.row) // Remove the interval if already selected
            } else {
                selectedIntervalIndices.insert(indexPath.row) // Add the interval if not selected
            }
        }
        updateDaysLabelText()
        // Reload the row to reflect the updated selection state
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - SegmentCustomView
extension RepeatViewViewController: SegmentCustomDelegate {
    func didTapItemAt(_ index: Int) {
        segmentItems = segmentItems.map { SegmentModel(title: $0.title, isSelected: false) }
        segmentItems[index].isSelected = true
        segmentCustomView.segmentItems = segmentItems
        updateView(for: index)
    }
    
    private func updateView(for index: Int) {
        switch index {
        case 0: setupDaily()
        case 1: setupMonthly()
        case 2: setupInterval()
        default: break
        }
    }
    
    private func setupDaily() {
        listRepeat = listDay
        repeatTableView.isHidden = false
        calendarView.isHidden = true
        repeatTableView.reloadData()
    }
    
    private func setupMonthly() {
        calendarView.isHidden = false
        repeatTableView.isHidden = true
    }
    
    private func setupInterval() {
        listRepeat = listInterval
        repeatTableView.isHidden = false
        calendarView.isHidden = true
        repeatTableView.reloadData()
    }
}
