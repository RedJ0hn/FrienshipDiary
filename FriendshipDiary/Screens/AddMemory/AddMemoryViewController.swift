//
//  AddMemoryViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 14/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class AddMemoryViewController: BaseViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var choosedPhotoImageView: UIImageView!
    
    lazy var presenter = AddMemoryViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.borderColor = UIColor.systemGray3.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        let mapTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addPinAction))
        mapView.addGestureRecognizer(mapTapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    @objc func addPinAction(gestureRecognizer: UITapGestureRecognizer) {
        mapView.removeAnnotations(mapView.annotations)
        let touchPoint: CGPoint = gestureRecognizer.location(in: mapView)
        let coordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        presenter.latitude = coordinate.latitude
        presenter.longitude = coordinate.longitude
    }
    
    func loadData() {
        SVProgressHUD.show()
        presenter.getFriends(successBlock: {
            self.friendsTableView.reloadData()
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DraftsViewController {
            destination.delegate = self
        }
    }

    @IBAction func choosePhoto(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)

    }
    
    @IBAction func publish(_ sender: Any) {
        presenter.title = titleTextField.text
        presenter.description = descriptionTextView.text
        SVProgressHUD.show()
        presenter.addMemory(successBlock: {
            self.resetViewController()
            self.tabBarController?.selectedIndex = 0
            SVProgressHUD.popActivity()
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
    @IBAction func saveToDrafts(_ sender: Any) {
        presenter.title = titleTextField.text
        presenter.description = descriptionTextView.text
        SVProgressHUD.show()
        presenter.addDraft(successBlock: {
            self.resetViewController()
            SVProgressHUD.showInfo(withStatus: "Done")
        }) { (error) in
            SVProgressHUD.showError(withStatus: error?.message)
        }
    }
    
    private func resetViewController() {
        titleTextField.text = ""
        descriptionTextView.text = ""
        choosedPhotoImageView.image = nil
        choosedPhotoImageView.isHidden = true
        for indexPath in friendsTableView.indexPathsForSelectedRows ?? [] {
            friendsTableView.deselectRow(at: indexPath, animated: true)
        }
        mapView.removeAnnotations(mapView.annotations)
    }
    
    private func configure(with draft: ApiItemMemory) {
        titleTextField.text = draft.title
        descriptionTextView.text = draft.description
        choosedPhotoImageView.image = UIImage.init(base64: draft.image)
        choosedPhotoImageView.isHidden = false
        for friendUsername in draft.friends ?? [] {
            if let index = presenter.friends.firstIndex(where: { (friend) -> Bool in
                return friend.username == friendUsername
            }) {
                friendsTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
            }
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: draft.localization?.latitude ?? 0, longitude: draft.localization?.longitude ?? 0)
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
    }
    
}

extension AddMemoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = friendsTableView.dequeueReusableCell(withIdentifier: "FriendCell") {
            let currentFriend = presenter.friends[indexPath.row]
            cell.textLabel?.text = (currentFriend.firstname ?? "") + " " + (currentFriend.lastname ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension AddMemoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let friendUsername = presenter.friends[indexPath.row].username {
            presenter.friendsToMemory.append(friendUsername)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let friendUsername = presenter.friends[indexPath.row].username, let index = presenter.friendsToMemory.firstIndex(of: friendUsername) {
            presenter.friendsToMemory.remove(at: index)
        }
    }
}

extension AddMemoryViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            choosedPhotoImageView.image = image
            choosedPhotoImageView.isHidden = false
            
            presenter.image = image.imageToBase64()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddMemoryViewController: DraftsViewControllerDelegate {
    
    func draftSelected(draft: ApiItemMemory) {
        configure(with: draft)
        presenter.configure(with: draft)
    }
    
}

extension AddMemoryViewController: UINavigationControllerDelegate {
    
}
