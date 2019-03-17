import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {

    static let Identifier = "ProductCollectionViewCell"

    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
            return view
        }()
    }

    func bind(with item: ProductSectionItem) {
        nameLabel.text = item.name
        nameLabel.textColor = item.labelColor
        backgroundColor = item.backgroundColor
    }
}
