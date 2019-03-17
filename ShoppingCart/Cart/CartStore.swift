import RxCocoa
import RxSwift

/// Logic(Mutatating) + Store
struct CartStore {

    var items: Observable<[ProductSectionItem]> { return _items.asObservable() }
    private let _items = BehaviorRelay<[ProductSectionItem]>(value: [])

    func add(_ item: ProductSectionItem) {
        _items.accept(_items.value + [item])
    }

    func remove(_ item: ProductSectionItem) {
        guard let index = _items.value.firstIndex(of: item) else { return }
        var mutableItems = _items.value
        mutableItems.remove(at: index)
        _items.accept(mutableItems)
    }
}
