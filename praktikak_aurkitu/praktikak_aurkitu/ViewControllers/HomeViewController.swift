import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Configuration initiale de l'interface utilisateur
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Logo de l'application (exemple)
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "AppLogo") // Assurez-vous d'avoir un asset "AppLogo"
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        
        // Nom de l'application
        let appNameLabel = UILabel()
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.text = "praktikak aurkitu"
        appNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        appNameLabel.textAlignment = .center
        view.addSubview(appNameLabel)
        
        // Bouton "Rechercher un stage"
        let searchButton = UIButton(type: .system)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Rechercher un stage", for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 10
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)
        
        // Contraintes Auto Layout
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            appNameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchButton.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func searchButtonTapped() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
