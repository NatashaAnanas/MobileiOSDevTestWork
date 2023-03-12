//
//  ViewController.swift
//  TestWork
//
//  Created by Анастасия Козлова on 07.03.2023.
//

//Реализовать экран с таблицей сделок.

//Реализуй сортировку таблицы по следующим полям:

//“дата изменения сделки“,
//“имя инструмента”,
//“цена сделки”,
//“объем сделки”
//и “сторона сделки”.
//При этом по умолчанию отсортируй таблицу по полю “дата изменения сделки“.
//Так же реализуй интерфейс изменения направления сортровки.

//Приходящие сделки перед отображением сортируй согласно выбранным параметрам сортировки.


import UIKit

final class TransactionViewController: UIViewController {
    
    private enum Constants {
        static let dealIidentifier = "DealCell"
        static let headerIidentifier = "HeaderCell"
        static let ellipsisImageName = "ellipsis.circle"
        static let sortText = "Сортировать по:"
        static let dateText = "Дата изменения"
        static let nameText = "Имени"
        static let priceText = "Цене"
        static let amountText = "Объему"
        static let sideText = "Стороне"
    }
    
    //    private enum FieldSorted {
    //        case date
    //        case instrument
    //        case price
    //        case amount
    //        case side
    //    }
    //
    //    private enum Order {
    //        case ascending
    //        case descending
    //    }
    
    private let transactionTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.ellipsisImageName), for: .normal)
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let ascendingButton: UIButton = {
        let button = UIButton()
        button.setTitle("По возрастанию", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let descendingButton: UIButton = {
        let button = UIButton()
        button.setTitle("По убыванию", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var presenter: TransactionPresenterProtocol?
    
    init(presenter: TransactionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getServerData()
    }
    
    private func setupUI() {
        createBarButtonItems()
        setupTableViewSettings()
        addActions()
        setupConstraints()
    }
    
    private func createBarButtonItems() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: sortButton),
            UIBarButtonItem(customView: ascendingButton),
            UIBarButtonItem(customView: descendingButton)
        ]
    }
    
    private func setupTableViewSettings() {
        view.addSubview(transactionTableView)
        transactionTableView.register(DealCell.self,
                                      forCellReuseIdentifier: Constants.dealIidentifier)
        transactionTableView.register(HeaderCell.self,
                                      forHeaderFooterViewReuseIdentifier: Constants.headerIidentifier)
        transactionTableView.dataSource = self
        transactionTableView.delegate = self
    }
    
    private func addActions() {
        sortButton.addTarget(self,
                             action: #selector(sortButtonAction(sender: )),
                             for: .touchUpInside)
        ascendingButton.addTarget(self,
                                  action: #selector(directionButtonAction(sender: )),
                                  for: .touchUpInside)
        descendingButton.addTarget(self,
                                   action: #selector(directionButtonAction(sender: )),
                                   for: .touchUpInside)
    }
    
    private func setupConstraints() {
        setupConstraintsTableView()
    }
    
    private func setupConstraintsTableView() {
        NSLayoutConstraint.activate([
            transactionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            transactionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transactionTableView.topAnchor.constraint(equalTo: view.topAnchor),
            transactionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func directionButtonAction(sender: UIButton) {
        presenter?.directionAction(tag: sender.tag)
    }
    
    @objc private func sortButtonAction(sender: UIButton) {
        
        let sort = UIMenu(title: Constants.sortText, options: .singleSelection, children: [
            
            UIAction(title: Constants.dateText, handler: { _ in
                self.presenter?.sortedTransaction(field: .date, order: .descending)
            }),
            
            UIAction(title: Constants.nameText, handler: { _ in
                self.presenter?.sortedTransaction(field: .instrument, order: .descending)
            }),
            
            UIAction(title: Constants.priceText, handler: { _ in
                self.presenter?.sortedTransaction(field: .price, order: .descending)
            }),
            
            UIAction(title: Constants.amountText, handler: { _ in
                self.presenter?.sortedTransaction(field: .amount, order: .descending)
            }),
            
            UIAction(title: Constants.sideText, handler: { _ in
                self.presenter?.sortedTransaction(field: .side, order: .descending)
            })
        ])
        sender.menu = sort
        sender.showsMenuAsPrimaryAction = true
    }
}

extension TransactionViewController: TransactionViewProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.transactionTableView.reloadData()
        }
    }
}

extension TransactionViewController: UITableViewDataSource, UITableViewDelegate {
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.dealIidentifier,
            for: indexPath) as? DealCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        guard let presenter else { return UITableViewCell() }
        cell.configure(model: presenter.model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: Constants.headerIidentifier) as? HeaderCell else { return UIView() }
        cell.configure()
        return cell
    }
}


