

import UIKit
import Firebase
class TableViewCell: UITableViewCell {

    static let cellName: String = "tableViewCell"


    public lazy var usernameTextView: LoginTextField = {
        let uTextField = LoginTextField()
        uTextField.translatesAutoresizingMaskIntoConstraints = false
        uTextField.autocorrectionType = .no
        uTextField.autocapitalizationType = .none
        uTextField.keyboardType = .alphabet
        uTextField.titleLabel.text = "Ingresa tu nombre"
        uTextField.text = ""
        uTextField.textColor = UIColor.black
        uTextField.placeholder = "Ingresa tu nombre"
        uTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        return uTextField
    }()
  
    @objc func textFieldDidChange(_ textField: UITextField) {
        let string :String = textField.text!
        print(string)
        let defaults = UserDefaults.standard
        defaults.set(string, forKey: "name")
    }
    
    private lazy var containerView: UIView = {
        let cView = UIView()
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = UIColor.clear
        return cView
    }()
    
   
    
    public lazy var photoLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.textColor = UIColor.black
        tLabel.text = "Tomar Fotografia"
        return tLabel
    }()
    public lazy var graphicLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.textColor = UIColor.black
        tLabel.numberOfLines = 7
        tLabel.text = """
Una gráfica o representación gráfica es un tipo de representación de datos, generalmente numéricos, mediante recursos visuales (líneas, vectores, superficies o símbolos), para que se manifieste visualmente la relación matemática o correlación estadística que guardan entre sí. También es el nombre de un conjunto de puntos que se plasman en coordenadas cartesianas y sirven para analizar el comportamiento de un proceso o un conjunto de elementos o signos que permiten la interpretación de un fenómeno. La representación gráfica permite establecer valores que no se han obtenido experimentalmente sino mediante la interpolación (lectura entre puntos) y la extrapolación (valores fuera del intervalo experimental).
"""
        return tLabel
    }()
    public lazy var pictureView: UIImageView = {
        let pView = UIImageView()
        pView.translatesAutoresizingMaskIntoConstraints = false
        pView.isHidden = false
        return pView
    }()

    private lazy var separatorView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = UIColor.darkGray
        sView.tintColor = UIColor.darkGray
        return sView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let  ref = Database.database().reference()
        ref.child("fondo").observe(.value, with: { [self](color) in
          
            print(color.value as! String)
            
            let color = UIColor(hexString: color.value as! String)

            containerView.backgroundColor = color

        })
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configure(index: Int) {
    
        if index == 0 {
            photoLabel.isHidden = true
            graphicLabel.isHidden = true


        }else if index  ==  1 {

            usernameTextView.isHidden = true
            graphicLabel.isHidden = true
        }else{
            photoLabel.isHidden = true
            usernameTextView.isHidden = true
            graphicLabel.isHidden = false
                }
    }
}

extension TableViewCell {
    func setupCell() {
        
        contentView.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
    
        containerView.addSubview(usernameTextView)
            
            usernameTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
            usernameTextView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 10).isActive = true
            usernameTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
            usernameTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true


            
            containerView.addSubview(photoLabel)

            photoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
            photoLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 10).isActive = true
            photoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
            photoLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true

            containerView.addSubview(graphicLabel)
            
            graphicLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
            graphicLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 10).isActive = true
            graphicLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
            graphicLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true

  
        
        
        containerView.addSubview(separatorView)
        
        separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -5).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1.3).isActive = true

        
    }
}
extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        //rint(self.usernameTextView.text)
    }
}
