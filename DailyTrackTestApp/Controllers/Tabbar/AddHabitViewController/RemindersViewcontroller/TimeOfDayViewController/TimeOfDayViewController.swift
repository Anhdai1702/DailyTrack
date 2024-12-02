import UIKit

class TimeOfDayViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var timeOfdayTableView: UITableView!
    @IBOutlet private weak var timeOfDayItems: UIView!
    @IBOutlet private weak var selectTimeLabel: UILabel!
    
    // MARK: - Variables
    private var listTime = [
        TimeOfDayModel(titleLabel: "Morning"),
        TimeOfDayModel(titleLabel: "Evening")
    ]
    private let defaultStorage = DefaultsStorageImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        registerCell()
        loadSavedValues()
        setupView()
    }
    
    private func setupView() {
        timeOfDayItems.backgroundColor = UIColor(resource: .timeOfDay)
        selectTimeLabel.text = "Any time"
    }

    private func registerCell() {
        timeOfdayTableView.setup(cellType: TimeOfDayTableViewCell.self, delegateAndDataSource: self)
    }
    
    // MARK: - Data Handling
    private func loadSavedValues() {
        guard let savedIndexes = defaultStorage.timeOfDay else { return }
        listTime.indices.forEach { index in
        // If savedIndexes contains the index of the item, set isSelected to true, indicating that the item was selected.
        // If not, set isSelected to false, indicating that the item was not selected.
        listTime[index].isSelected = savedIndexes.contains(index)
        }
        timeOfdayTableView.reloadData()
    }
}

// MARK: - Actions
extension TimeOfDayViewController {
    
    @IBAction func didTapBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TimeOfDayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeOfDayTableViewCell", for: indexPath) as? TimeOfDayTableViewCell else {
            return UITableViewCell()
        }
        let model = listTime[indexPath.row]
        cell.configureTimeOfDay(model: model)
        cell.toggleSelection(isSelected: !model.isSelected)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedIndexes = defaultStorage.timeOfDay ?? []
        // Toggle the selection state
        if let index = selectedIndexes.firstIndex(of: indexPath.row) {
            selectedIndexes.remove(at: index)  // Deselect
        } else {
            selectedIndexes.append(indexPath.row)  // Select
        }
        // Save the updated indexes
        defaultStorage.timeOfDay = selectedIndexes
        // Update the model and reload the row
        listTime[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
}
