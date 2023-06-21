//  
//  ListSceneViewController.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import UIKit
import Combine

class ListSceneViewController: UIViewController, StoryboardInstantiable {
    // MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VARs
    private var subscriptions: Set<AnyCancellable> = []

    internal var router: any ListSceneRouterType = DIRepository.shared.resolve()
    internal var viewModel: any ListSceneViewModelType = DIRepository.shared.resolve()

    private var tableDataSource: [CharacterDomain] = []

    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.linkModelAndRouter()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.linkModelAndRouter()
    }

    // MARK: - CLASS IMPLEMENTATION
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.viewModel.viewDidLoad()
    }

    func bind() {
        subscriptions = [
            self.viewModel.characters
                .sink {
                if let data = $0 {
                    self.updateTableDataSource(data)
                }
            }
        ]
    }

    // MARK: - ACTIONS

}

extension ListSceneViewController {
    private func linkModelAndRouter() {
        self.router.context = self
        self.viewModel.router = self.router
    }

    private func updateTableDataSource(_ newDataSource: [CharacterDomain]) {
        self.tableDataSource = newDataSource
        self.tableView.reloadData()
    }
}

extension ListSceneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "test")
        let item = self.tableDataSource[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}
