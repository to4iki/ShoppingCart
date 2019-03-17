import RxDataSources

/// BindingModel
///
/// - Note: use `CollectionView.Section`, `TableView.Section`
enum ProductSectionModel: AnimatableSectionModelType, Equatable {
    typealias Item = ProductSectionItem

    case product(items: [Item])

    var items: [Item] {
        switch self {
        case .product(let items):
            return items
        }
    }

    var identity: String {
        switch self {
        case .product:
            return "product"
        }
    }

    init(original: ProductSectionModel, items: [Item]) {
        switch original {
        case .product:
            self = .product(items: items)
        }
    }
}
