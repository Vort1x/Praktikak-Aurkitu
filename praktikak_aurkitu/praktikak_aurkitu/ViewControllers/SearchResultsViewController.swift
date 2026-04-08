import UIKit

class SearchResultsViewController: UIViewController {

    // MARK: - Properties
    private let filters: SearchFilters
    private var jobOffers: [JobOffer] = []
    private let jobService = JobService.shared
    private var currentPage = 0
    private let itemsPerPage = 20
    private var isLoading = false
    
    // MARK: - UI Elements
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let noResultsLabel = UILabel()

    // MARK: - Initialization
    init(filters: SearchFilters) {
        self.filters = filters
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        fetchJobOffers()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "Résultats de recherche"
        
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JobOfferCell.self, forCellReuseIdentifier: JobOfferCell.reuseIdentifier)
        tableView.tableFooterView = UIView() // Supprime les cellules vides
        view.addSubview(tableView)
        
        // Activity Indicator
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        // No Results Label
        noResultsLabel.text = "Aucune offre trouvée pour votre recherche."
        noResultsLabel.textAlignment = .center
        noResultsLabel.textColor = .gray
        noResultsLabel.isHidden = true
        view.addSubview(noResultsLabel)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Data Fetching
    private func fetchJobOffers() {
        guard !isLoading else { return }
        isLoading = true
        activityIndicator.startAnimating()
        noResultsLabel.isHidden = true
        
        Task {
            do {
                let newOffers = try await jobService.searchJobs(filters: filters, page: currentPage, limit: itemsPerPage)
                if newOffers.isEmpty && jobOffers.isEmpty {
                    noResultsLabel.isHidden = false
                } else {
                    jobOffers.append(contentsOf: newOffers)
                    tableView.reloadData()
                    currentPage += 1
                }
            } catch {
                print("Erreur lors de la récupération des offres: \(error)")
                // Afficher une alerte à l'utilisateur
                showAlert(title: "Erreur", message: "Impossible de charger les offres. Veuillez réessayer.")
            }
            isLoading = false
            activityIndicator.stopAnimating()
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension SearchResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobOfferCell.reuseIdentifier, for: indexPath) as? JobOfferCell else {
            return UITableViewCell()
        }
        let offer = jobOffers[indexPath.row]
        cell.configure(with: offer)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedOffer = jobOffers[indexPath.row]
        let detailVC = JobDetailViewController(jobOffer: selectedOffer)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Charger plus d'offres lorsque l'utilisateur atteint la fin de la liste
        if indexPath.row == jobOffers.count - 1 && !isLoading {
            fetchJobOffers()
        }
    }
}
