import UIKit

final class ProductTableViewCell: UITableViewCell {

    static let Identifier = "ProductTableViewCell"

    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func bind(with item: ProductSectionItem) {
        nameLabel.text = item.name
        nameLabel.textColor = item.labelColor
        backgroundColor = item.backgroundColor
    }
}
