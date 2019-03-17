import RxCocoa
import RxSwift
import RxDataSources
import UIKit

final class CartViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let emptyView: CartEmptyView = {
        let view = CartEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dataSource = RxTableViewSectionedAnimatedDataSource<ProductSectionModel>(
        animationConfiguration: AnimationConfiguration(deleteAnimation: .fade),
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.Identifier, for: indexPath) as! ProductTableViewCell
            cell.bind(with: item)
            return cell
        }
    )

    /// dependency
    private var cartBloc: CartBloc!

    private let disposeBag = DisposeBag()
}

// MARK: - Storyboardable

extension CartViewController: Storyboardable {

    typealias Dependency = CartBloc

    static func makeFromStoryboard(dependency: Dependency) -> CartViewController {
        let viewController = unsafeMakeFromStoryboard()
        viewController.cartBloc = dependency
        return viewController
    }
}

// MARK: - Lifecycle

extension CartViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Cart"

        layout: do {
            view.addSubview(emptyView)
            NSLayoutConstraint.activate([
                emptyView.topAnchor.constraint(equalTo: view.topAnchor),
                emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                ])
        }

        tableView: do {
            tableView.rx.setDelegate(self)
                .disposed(by: disposeBag)

            tableView.rx.modelSelected(ProductSectionItem.self)
                .bind(to: cartBloc.input.removeItem)
                .disposed(by: disposeBag)
        }

        cartBloc: do {
            cartBloc.output.sections
                .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)

            cartBloc.output.isEmptyViewHidden
                .bind(to: emptyView.rx.isHidden)
                .disposed(by: disposeBag)
        }
    }
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
