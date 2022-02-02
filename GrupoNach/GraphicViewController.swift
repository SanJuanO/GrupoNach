//
//  NotificationDetailViewController.swift
//  RecompensasSuperAuto
//
//  Created by Sergio Acosta Vega on 23/6/21.
//

import UIKit
import Charts
import Firebase

class GraphicViewController: GeneralViewController, ChartViewDelegate {


 

    private lazy var barcharview: PieChartView = {
        let barcharview = PieChartView()
        barcharview.delegate = self
        barcharview.translatesAutoresizingMaskIntoConstraints = false
        barcharview.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        //barcharview.center = view.center
        return barcharview
    }()
    

    private lazy var barcharview2: PieChartView = {
        let barcharview = PieChartView()
        barcharview.delegate = self
        barcharview.translatesAutoresizingMaskIntoConstraints = false
        barcharview.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        //barcharview.center = view.center
        return barcharview
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.text = "¿Esta limpia la sucursal?"
        tLabel.textAlignment = .center
        tLabel.textColor = .black
        return tLabel
    }()
    

    
 
    func configure() {
      
    }
    
    override func makeRequest(completion: (() -> Void)? = nil) {
        let requestAction = RequestAction(endpoint: .graphic)
        
        httpRequest.makeRequest(onAction: requestAction,
                              response: Success.self,
                               onSuccess: { succes in
            print(succes)
          
            let option = succes.questions[0].chartData.count
            let option1 = succes.questions[1].chartData.count
           
            var entries = [ChartDataEntry]()
            var entries2 = [ChartDataEntry]()

            print(option)
            for x in 0...option-1 {
                entries.append(PieChartDataEntry(value: Double(succes.questions[0].chartData[x].percetnage), label: succes.questions[0].chartData[x].text, data:  "" as AnyObject))
            }
            
            for x in 0...option1-1 {
                entries2.append(PieChartDataEntry(value: Double(succes.questions[1].chartData[x].percetnage), label: succes.questions[1].chartData[x].text, data:  "" as AnyObject))
            }
            

            let set = PieChartDataSet(entries:entries)
            let set2 = PieChartDataSet(entries:entries2)

            var colors: [UIColor] = []

            for c in 0...succes.colors.count-1 {

                let color = UIColor(hexString: succes.colors[c])
                print(color) // r 0.0 g 0.0 b 1.0 a 1.0
                colors.append(color)
            }
            
            print(colors)
            set.colors = colors
            set2.colors = colors
            let data = PieChartData(dataSet: set)
            let data2 = PieChartData(dataSet: set2)

            self.barcharview.data = data
            self.barcharview2.data = data2

            
        }, onFailure: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let  ref = Database.database().reference()
        ref.child("fondo").observe(.value, with: {(color) in
          
            print(color.value as! String)
            
            let color = UIColor(hexString: color.value as! String)

            self.view.backgroundColor = color

        })
    }
    
    override func setupController() {
        super.setupController()
        
        view.addSubview(titleLabel)
        view.addSubview(barcharview)
        view.addSubview(barcharview2)

 
        titleLabel.leadingAnchor.constraint(equalTo:  view.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo:  view.topAnchor, constant: 80.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:  view.trailingAnchor).isActive = true
        

    
        barcharview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        barcharview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        barcharview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        barcharview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barcharview.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -10.0).isActive = true
  
        barcharview2.topAnchor.constraint(equalTo: barcharview.bottomAnchor, constant: 20.0).isActive = true
        barcharview2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        barcharview2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        barcharview2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barcharview2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
