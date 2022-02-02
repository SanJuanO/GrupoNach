//
//  ViewController.swift
//  GrupoNach
//
//  Created by Oscar San juan on 01/02/22.
//

import UIKit
import Firebase

class MainViewController: GeneralViewController, ImageViewDelegate {
    func image(image: String) {
        self.image = image
    }
    
    var name : String = ""
    var image: String = ""
    weak var delegate: ImageViewDelegate?

    let db = Firestore.firestore()
    private lazy var titleLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.text = "Bienvenidos"
        tLabel.textColor = UIColor.black
        tLabel.textAlignment = .center
        tLabel.numberOfLines = 0
        return tLabel
    }()
  
    
    private lazy var mainTableView: GeneralTableView = {
        let mtView = GeneralTableView()
        mtView.translatesAutoresizingMaskIntoConstraints = false
        mtView.delegate = self
        mtView.dataSource = self
   
        mtView.register(TableViewCell.self,
                           forCellReuseIdentifier: TableViewCell.cellName)
        mtView.bounces = true
        mtView.refreshControl = refreshControl
        return mtView
    }()
    
    public lazy var actionButton: UIButton = {
        let lButton = UIButton()
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        lButton.translatesAutoresizingMaskIntoConstraints = false
        lButton.setTitle("Enviar información", for: .normal)
        lButton.setTitleColor(UIColor.black, for: .normal)
        lButton.layer.masksToBounds = true
        lButton.backgroundColor = UIColor.clear
        lButton.layer.borderWidth = 1.0
        lButton.layer.borderColor = UIColor.black.cgColor
        lButton.layer.cornerRadius = cornerRadius
        lButton.addTarget(self, action: #selector(save), for: .touchUpInside)
      
        return lButton
    }()
   
    
    
    @objc func save() {
        let defaults = UserDefaults.standard
        name = defaults.string(forKey: "name")!
        print(name)
        
        if name == "" {
            self.showErrorAlert(message: "Ingresa un nombre")
        }
        else if  image == "" {
            self.showErrorAlert(message: "Toma una fotografia")

        }
        else{
             db.collection("users").document(name).setData(["nombre":name,"photo": image])
            self.showInfoAlert(imageName: "logo", title: "Felicidad", message: "Listo quedo guardo", completion: nil)

        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     //   self.navigationController?.navigationBar.isTranslucent = true
        let  ref = Database.database().reference()
        ref.child("fondo").observe(.value, with: {(color) in
          
            print(color.value as! String)
            
            let color = UIColor(hexString: color.value as! String)

            self.view.backgroundColor = color

        })
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "name")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

    }
    
    override func setupController() {
        super.setupController()
        view.backgroundColor = UIColor.white
        view.addSubview(titleLabel)

        view.addSubview(mainTableView)
        view.addSubview(actionButton)

        
            
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 80).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 30).isActive = true
      mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        actionButton.topAnchor.constraint(equalTo: mainTableView.bottomAnchor, constant: 20).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
    }

   
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TableViewCell.cellName
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
         
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
            return 3
     
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TableViewCell {
            print(indexPath.item)
            print(indexPath.row)

           cell.configure(index: indexPath.row)
         
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // didTapCamera()
        
        if indexPath.item == 0{
 
        }else if  indexPath.item == 1{
            
            let detailController = AlertViewController()
            detailController.modalTransitionStyle = .crossDissolve
            detailController.delegate = self
            detailController.modalPresentationStyle = .custom
            present(detailController, animated: true, completion: nil)
            
        }else{
            let detailController = GraphicViewController()
        
            present(detailController, animated: true, completion: nil)

        }
     
    }
}



  


