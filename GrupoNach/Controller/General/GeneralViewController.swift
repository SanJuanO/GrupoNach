//
//  GeneralViewController.swift
//  Heartland Splenda
//
//  Created by Edgar Gerardo Flores Lopez on 21/09/20.
//  Copyright © 2020 Edgar Gerardo Flores Lopez. All rights reserved.
//

import UIKit

class GeneralViewController: UIViewController {
    
    internal let httpRequest = HttpRequest.shared

    internal var bottomConstraint: NSLayoutConstraint!
    internal let screenSize: CGRect = UIScreen.main.bounds
    internal lazy var generalErrorHandler: (String, HttpStatusCode) -> Void = { error, errorCode in
        
        switch errorCode {
        case .upgradeRequired:
            DispatchQueue.main.async {
                self.hudView.isHidden = true
                self.isRefreshing = false
                self.refreshControl.endRefreshing()
            }
        default:
            self.showErrorAlert(message: error)
            DispatchQueue.main.async {
                self.hudView.isHidden = true
                self.isRefreshing = false
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    internal lazy var refreshControl: UIRefreshControl = {
        let rControll = UIRefreshControl()
        rControll.tintColor = .black
        rControll.addTarget(self, action: #selector(fetchNewData), for: .valueChanged)
        return rControll
    }()
    
    internal lazy var hudView: HudView = {
        let hView = HudView()
        hView.translatesAutoresizingMaskIntoConstraints = false
        hView.layer.masksToBounds = true
        hView.layer.cornerRadius = 10.0
        hView.isHidden = true
        return hView
    }()
    
    var isRefreshing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        getDataFromDisk()
        fetchNewData()
        initializeHideKeyboard()
        view.bringSubviewToFront(hudView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.endEditing(true)
        addKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        removeKeyboardNotification()
    }
    
    @objc func fetchNewData() {
        
//        guard !isRefreshing else {
//            self.refreshControl.endRefreshing()
//            return
//        }
//        
//        isRefreshing = true
        makeRequest()
    }
    
    func makeRequest(completion: (() -> Void)? = nil) {
        refreshControl.endRefreshing()
    }
    
    func getDataFromDisk() {}
    
    internal func setupController() {
        view.backgroundColor = .white
            
        view.addSubview(hudView)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain,
                                                            target: nil, action: nil)
        
        hudView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hudView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        hudView.heightAnchor.constraint(equalTo: hudView.widthAnchor).isActive = true
        hudView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    /// Setting observers for keyboard
    func addKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(handleKeyboardNotification),
                                       name: UIResponder.keyboardWillShowNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(handleKeyboardNotification),
                                       name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    /// Action when keyboard appears and disappear
    @objc func handleKeyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo, bottomConstraint != nil else { return }
        let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        if notification.name == UIResponder.keyboardWillShowNotification, let height = keyBoardFrame?.height {
            bottomConstraint.constant = -height
        } else {
            bottomConstraint.constant = 0.0
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let accept: UIAlertAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(accept)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showInfoAlert(imageName: String? = nil, title: String? = nil, message: String? = nil, completion: [(UIAlertAction) -> Void]? = nil) {
        DispatchQueue.main.async {
            let detailController = ErrorAlertViewController()
            detailController.modalTransitionStyle = .crossDissolve
            detailController.modalPresentationStyle = .custom
            detailController.alertView.iconView.image = UIImage(named: imageName ?? "")
            detailController.alertView.titleLabel.text = title
            detailController.alertView.messageTextView.text = message
//            detailController.alertView.actions = completion
            self.present(detailController, animated: true, completion: nil)
        }
    }
    func showOptionAlert(imageName: String? = nil, title: String? = nil, message: String? = nil, completion: [(UIAlertAction) -> Void]? = nil) {
        DispatchQueue.main.async {
            let detailController = AlertViewController()
            detailController.modalTransitionStyle = .crossDissolve
            detailController.modalPresentationStyle = .custom
//            detailController.alertView.actions = completion
            self.present(detailController, animated: true, completion: nil)
        }
    }
    
    func initializeHideKeyboard(){
//        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(dismissMyKeyboard))
//        //Add this tap gesture recognizer to the parent view
//        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        view.endEditing(true)
        super.dismiss(animated: flag, completion: completion)
    }
    
}
