//
//  MemoriesViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 13/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import SVProgressHUD

class MemoriesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var presenter = MemoriesViewPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 325
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SVProgressHUD.show()
        presenter.loadMemories(successBlock: {
            self.tableView.reloadData()
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
}

extension MemoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.memories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell") as? MemoryTableViewCell {
            let currentMemory = presenter.memories[indexPath.row]
            cell.configure(with: currentMemory)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
