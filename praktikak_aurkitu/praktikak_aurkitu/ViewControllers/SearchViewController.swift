import UIKit

class SearchViewController: UIViewController {

    // MARK: - UI Elements
    private let searchBar = UISearchBar()
    private let locationTextField = UITextField()
    private let contractTypeSegmentedControl = UISegmentedControl(items: ["Stage", "Alternance", "Emploi"])
    private let searchButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "Rechercher une offre"
        
        // Search Bar
        searchBar.placeholder = "Mot-clé (ex: Développeur iOS)"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        // Location Text Field
        locationTextField.placeholder = "Localisation (ex: Paris)"
        locationTextField.borderStyle = .roundedRect
        view.addSubview(locationTextField)
        
        // Contract Type Segmented Control
        contractTypeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        view.addSubview(contractTypeSegmentedControl)
        
        // Search Button
        searchButton.setTitle("Lancer la recherche", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        searchButton.backgroundColor = .systemGreen
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 10
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        contractTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            locationTextField.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationTextField.heightAnchor.constraint(equalToConstant: 44),
            
            contractTypeSegmentedControl.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 20),
            contractTypeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contractTypeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contractTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            searchButton.topAnchor.constraint(equalTo: contractTypeSegmentedControl.bottomAnchor, constant: 40),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    @objc private func searchButtonTapped() {
        let filters = SearchFilters(
            keyword: searchBar.text,
            location: locationTextField.text,
            contractType: selectedContractType()
        )
        
        let resultsVC = SearchResultsViewController(filters: filters)
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    private func selectedContractType() -> String? {
        switch contractTypeSegmentedControl.selectedSegmentIndex {
        case 0: return "Stage"
        case 1: return "Alternance"
        case 2: return "Emploi"
        default: return nil
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Masquer le clavier
        searchButtonTapped()
    }
}
