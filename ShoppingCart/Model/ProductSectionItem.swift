import RxDataSources
import UIKit

/// BindingModel
///
/// - Note: use `CollectionView.Section.Item`, `TableView.Sectino.Row`
struct ProductSectionItem: Equatable, IdentifiableType {
    struct ID: Equatable {
        let value: String

        init(_ value: String) {
            self.value = value
        }
    }

    let id: ID
    let name: String
    let labelColor: UIColor
    let backgroundColor: UIColor

    var identity: String {
        return id.value
    }
}

// MARK: - ProductSectionItemDataSource

enum ProductSectionItemDataSource {
    /// sample data
    static let items = [
        ProductSectionItem(id: ProductSectionItem.ID("1"), name: "apple", labelColor: .white, backgroundColor: .red),
        ProductSectionItem(id: ProductSectionItem.ID("2"), name: "lemon", labelColor: .black, backgroundColor: .yellow),
        ProductSectionItem(id: ProductSectionItem.ID("3"), name: "avocado", labelColor: .black, backgroundColor: .green),
        ProductSectionItem(id: ProductSectionItem.ID("4"), name: "blueberry", labelColor: .black, backgroundColor: .cyan),
        ProductSectionItem(id: ProductSectionItem.ID("5"), name: "almond", labelColor: .white, backgroundColor: .brown),
        ProductSectionItem(id: ProductSectionItem.ID("6"), name: "grape", labelColor: .white, backgroundColor: .magenta),
        ProductSectionItem(id: ProductSectionItem.ID("7"), name: "plum", labelColor: .white, backgroundColor: .orange),
        ProductSectionItem(id: ProductSectionItem.ID("8"), name: "blue hawaii", labelColor: .white, backgroundColor: .blue),
        ProductSectionItem(id: ProductSectionItem.ID("9"), name: "melon", labelColor: .black, backgroundColor: .green),
        ProductSectionItem(id: ProductSectionItem.ID("10"), name: "chocolate", labelColor: .white, backgroundColor: .brown),
        ProductSectionItem(id: ProductSectionItem.ID("11"), name: "mango", labelColor: .white, backgroundColor: .orange),
        ProductSectionItem(id: ProductSectionItem.ID("12"), name: "strawberry", labelColor: .white, backgroundColor: .red),
    ]
}
