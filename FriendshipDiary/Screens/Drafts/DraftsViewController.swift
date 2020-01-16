//
//  DraftsViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 16/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol DraftsViewControllerDelegate: class {
    func draftSelected(draft: ApiItemMemory)
}

class DraftsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var presenter = DraftsViewPresenter()
    weak var delegate: DraftsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDrafts()
    }
    
    func loadDrafts() {
        SVProgressHUD.show()
        presenter.getDrafts(successBlock: {
            SVProgressHUD.popActivity()
            self.tableView.reloadData()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }

}

extension DraftsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.drafts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DraftCell") {
            cell.textLabel?.text = presenter.drafts[indexPath.row].title
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension DraftsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.draftSelected(draft: presenter.drafts[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
}
