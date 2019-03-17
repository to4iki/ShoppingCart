import RxCocoa
import RxSwift

final class CatalogSectionBloc: Bloc {

    let input = Input()
    let output = Output()

    private let disposeBag = DisposeBag()

    init() {
        input._viewDidLoad.asObservable()
            .map { _ in [ProductSectionModel.product(items: ProductSectionItemDataSource.items)] }
            .bind(to: output._sections)
            .disposed(by: disposeBag)
    }
}

// MARK: - Input

extension CatalogSectionBloc {

    struct Input {
        var viewDidLoad: AnyObserver<Void> { return _viewDidLoad.asObserver() }
        fileprivate let _viewDidLoad = PublishSubject<Void>()
    }
}

// MARK: - Output

extension CatalogSectionBloc {

    struct Output {
        var sections: Observable<[ProductSectionModel]> { return _sections.asObservable() }
        fileprivate let _sections = BehaviorRelay<[ProductSectionModel]>(value: [])
    }
}
