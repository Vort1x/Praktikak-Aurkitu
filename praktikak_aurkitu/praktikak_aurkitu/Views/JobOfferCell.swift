import UIKit

class JobOfferCell: UITableViewCell {
    static let reuseIdentifier = "JobOfferCell"
    
    private let titleLabel = UILabel()
    private let companyLabel = UILabel()
    private let locationLabel = UILabel()
    private let contractTypeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        companyLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        companyLabel.textColor = .darkGray
        contentView.addSubview(companyLabel)
        
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .gray
        contentView.addSubview(locationLabel)
        
        contractTypeLabel.font = UIFont.systemFont(ofSize: 14)
        contractTypeLabel.textColor = .systemBlue
        contentView.addSubview(contractTypeLabel)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contractTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            companyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            companyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            companyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 5),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            contractTypeLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            contractTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contractTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            contractTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with offer: JobOffer) {
        titleLabel.text = offer.title
        companyLabel.text = offer.company
        locationLabel.text = offer.location
        contractTypeLabel.text = offer.contractType
    }
}
