import UIKit
import SafariServices

class JobDetailViewController: UIViewController {

    // MARK: - Properties
    private let jobOffer: JobOffer
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let companyLabel = UILabel()
    private let locationLabel = UILabel()
    private let contractTypeLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let applyButton = UIButton(type: .system)
    private let favoriteButton = UIButton(type: .system)

    // MARK: - Initialization
    init(jobOffer: JobOffer) {
        self.jobOffer = jobOffer
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
        configure(with: jobOffer)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "Détail de l'offre"
        
        // ScrollView et ContentView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Labels
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        companyLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        companyLabel.textColor = .darkGray
        contentView.addSubview(companyLabel)
        
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.textColor = .gray
        contentView.addSubview(locationLabel)
        
        contractTypeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        contractTypeLabel.textColor = .systemBlue
        contentView.addSubview(contractTypeLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
        
        // Bouton Postuler
        applyButton.setTitle("Postuler", for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        applyButton.backgroundColor = .systemGreen
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.cornerRadius = 10
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        contentView.addSubview(applyButton)
        
        // Bouton Favoris
        favoriteButton.setTitle("Ajouter aux favoris", for: .normal)
        favoriteButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        favoriteButton.backgroundColor = .systemOrange
        favoriteButton.setTitleColor(.white, for: .normal)
        favoriteButton.layer.cornerRadius = 10
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        contentView.addSubview(favoriteButton)
        
        updateFavoriteButtonState()
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contractTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            companyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            companyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            companyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 5),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            contractTypeLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            contractTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contractTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: contractTypeLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            applyButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            applyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            applyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            applyButton.heightAnchor.constraint(equalToConstant: 50),
            
            favoriteButton.topAnchor.constraint(equalTo: applyButton.bottomAnchor, constant: 15),
            favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configure(with offer: JobOffer) {
        titleLabel.text = offer.title
        companyLabel.text = offer.company
        locationLabel.text = offer.location
        contractTypeLabel.text = offer.contractType
        descriptionLabel.text = offer.description ?? "Pas de description disponible."
        
        applyButton.isEnabled = offer.applicationURL != nil
        applyButton.backgroundColor = offer.applicationURL != nil ? .systemGreen : .lightGray
    }
    
    private func updateFavoriteButtonState() {
        if FavoritesManager.shared.isFavorite(jobOffer) {
            favoriteButton.setTitle("Retirer des favoris", for: .normal)
            favoriteButton.backgroundColor = .systemRed
        } else {
            favoriteButton.setTitle("Ajouter aux favoris", for: .normal)
            favoriteButton.backgroundColor = .systemOrange
        }
    }
    
    // MARK: - Actions
    @objc private func applyButtonTapped() {
        guard let url = jobOffer.applicationURL else {
            showAlert(title: "Erreur", message: "L'URL de candidature n'est pas disponible.")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    @objc private func favoriteButtonTapped() {
        if FavoritesManager.shared.isFavorite(jobOffer) {
            FavoritesManager.shared.removeFavorite(jobOffer)
        } else {
            FavoritesManager.shared.addFavorite(jobOffer)
        }
        updateFavoriteButtonState()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
