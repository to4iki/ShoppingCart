import RxCocoa
import RxSwift

final class CartBloc: Bloc {

    let input = Input()
    let output = Output()

    private let disposeBag = DisposeBag()

    init(cartStore: CartStore = CartStore()) {
        input._addItem
            .subscribe(onNext: { item in
                cartStore.add(item)
            })
            .disposed(by: disposeBag)

        input._removeItem
            .subscribe(onNext: { item in
                cartStore.remove(item)
            })
            .disposed(by: disposeBag)

        cartStore.items
            .bind(to: output._items)
            .disposed(by: disposeBag)
    }
}

// MARK: - Input

extension CartBloc {

    struct Input {
        var addItem: AnyObserver<ProductSectionItem> { return _addItem.asObserver() }
        fileprivate let _addItem = PublishSubject<ProductSectionItem>()

        var removeItem: AnyObserver<ProductSectionItem> { return _removeItem.asObserver() }
        fileprivate let _removeItem = PublishSubject<ProductSectionItem>()
    }
}

// MARK: - Output

extension CartBloc {

    struct Output {
        fileprivate let _items = BehaviorRelay<[ProductSectionItem]>(value: [])

        var sections: Observable<[ProductSectionModel]> {
            return _items.map { items in
                [ProductSectionModel.product(items: items)]
            }
        }

        var count: Observable<String> {
            return _items.map { $0.count.description }
        }

        var isEmptyViewHidden: Observable<Bool> {
            return _items.map { !$0.isEmpty }
        }
    }
}
