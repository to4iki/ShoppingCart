import RxCocoa
import RxSwift
import RxDataSources
import UIKit

final class CatalogViewController: UIViewController {

    @IBOutlet private weak var cartButtonItem: UIBarButtonItem!
    @IBOutlet private weak var collectionView: UICollectionView!

    private let dataSource = RxCollectionViewSectionedReloadDataSource<ProductSectionModel>(
        configureCell: { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.Identifier, for: indexPath) as! ProductCollectionViewCell
            cell.bind(with: item)
            return cell
        }
    )

    /// dependency
    private var catalogSectionBloc: CatalogSectionBloc!
    private var cartBloc: CartBloc!

    private let disposeBag = DisposeBag()
}

// MARK: - Storyboardable

extension CatalogViewController: Storyboardable {

    typealias Dependency = (
        catalogSectionBloc: CatalogSectionBloc,
        cartBloc: CartBloc
    )

    static func makeFromStoryboard(dependency: Dependency) -> CatalogViewController {
        let viewController = unsafeMakeFromStoryboard()
        viewController.catalogSectionBloc = dependency.catalogSectionBloc
        viewController.cartBloc = dependency.cartBloc
        return viewController
    }
}

// MARK: - Lifecycle

extension CatalogViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Catalog"

        cartButtonItem: do {
            cartButtonItem.rx.tap
                .throttle(0.5, latest: true, scheduler: ConcurrentMainScheduler.instance)
                .subscribe(onNext: { [weak self] in
                    guard let me = self else { return }
                    let viewController = CartViewController.makeFromStoryboard(dependency: me.cartBloc)
                    me.navigationController?.pushViewController(viewController, animated: true)
                })
                .disposed(by: disposeBag)
        }

        collectionView: do {
            collectionView.rx.setDelegate(self)
                .disposed(by: disposeBag)

            collectionView.rx.modelSelected(ProductSectionItem.self)
                .bind(to: cartBloc.input.addItem)
                .disposed(by: disposeBag)
        }

        productCollectionBloc: do {
            catalogSectionBloc.input.viewDidLoad.onNext(())

            catalogSectionBloc.output.sections
                .bind(to: collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }

        cartBloc: do {
            cartBloc.output.count
                .bind(to: cartButtonItem.rx.title)
                .disposed(by: disposeBag)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CatalogViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
