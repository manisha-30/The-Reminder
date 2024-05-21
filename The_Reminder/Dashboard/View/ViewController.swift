//
//  ViewController.swift
//  The_Reminder
//
//  Created by Ashok on 04/01/24.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {
    
   
    @IBOutlet weak var inTakeLabel: UILabel!
    @IBOutlet weak var addQuantity: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var animateLabel: UILabel!
    @IBOutlet weak var outerCircleView: UIView!
    @IBOutlet weak var innercircle: UIView!
    @IBOutlet weak var tableView: ContentSizedTableView!
    @IBOutlet weak var swapImage: UIImageView!
    @IBOutlet weak var swapView: UIView!
    
    let shapeLayer = CAShapeLayer()
    var wdatas : Results<WDatas>!
    let realm = try! Realm()
    var additionalCups = NSArray()
    var backGroundView = UIView()
    let vm = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "DailyRecordCell", bundle: nil), forCellReuseIdentifier: "DailyRecordCell")
        vm.getValue{
            datas in
            if let finalData = datas{
                self.wdatas = finalData
            }
        }
        setupUI()
        drawSemiCircle()
        updateIntakeValue(intakeQuantity: 0)
    }
    func drawSemiCircle(){
        
        let center = CGPoint(x: outerCircleView.frame.width / 2, y: outerCircleView.frame.height / 2)
        let semiCirclePath = UIBezierPath(arcCenter: center, radius: innercircle.frame.width / 2 + 25 , startAngle: CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
        //semiCirclePath.close()
        shapeLayer.path = semiCirclePath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 7
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.outerCircleView.layer.addSublayer(shapeLayer)
        
    }
    
    @objc func handleSemicircle(){
        print("hell world")
        
        tipLabel.text = AdditionalCups.init().getTips()
        let animate = CABasicAnimation(keyPath: "strokeEnd")
        animate.toValue = 1
        animate.duration = 3
        animate.fillMode = .forwards
        animate.isRemovedOnCompletion = false
        shapeLayer.add(animate, forKey: "drawCircle")
        
       
        vm.addValue()
        vm.getValue{
            datas in
            if let finalData = datas{
                self.wdatas = finalData
                self.tableView.reloadData()
            }
        }
        animateLabel.transform = .identity

        updateIntakeValue(intakeQuantity: 100)
        
        UIView.animate(withDuration: 1.5){
            self.animateLabel.alpha = 1
            self.animateLabel.transform = CGAffineTransform(translationX: 0, y: -50)
            self.animateLabel.alpha = 0
        }
    }
    func setupUI(){
        animateLabel.alpha = 0
        animateLabel.textColor = hexStringToUIColor(hex: "#0ACBFF")
        
        tipLabel.layer.cornerRadius = 10
        tipLabel.layer.masksToBounds = true
        
        innercircle.layer.cornerRadius = innercircle.frame.width / 2
        innercircle.layer.masksToBounds = false
        innercircle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSemicircle)))
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5  // Adjust the corner radius as needed
        tableView.layer.shadowColor = UIColor.black.cgColor  // Adjust the shadow color as needed
        tableView.layer.shadowOffset = CGSize(width: 0, height: 2)  // Adjust the shadow offset as needed
        tableView.layer.shadowOpacity = 0.5  // Adjust the shadow opacity as needed
        tableView.layer.shadowRadius = 2  // Adjust the shadow radius as needed
        tableView.layer.masksToBounds = false
        
        swapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(swapCups)))
        
        let trackLayer = CAShapeLayer()
        let center = CGPoint(x: outerCircleView.frame.width / 2, y: outerCircleView.frame.height / 2)
        let semiCirclePath = UIBezierPath(arcCenter: center, radius: innercircle.frame.width / 2 + 25 , startAngle: CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = semiCirclePath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 7
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        self.outerCircleView.layer.addSublayer(trackLayer)
        

        innercircle.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        innercircle.layer.shadowColor = UIColor.gray.cgColor
        innercircle.layer.shadowRadius = 7
        innercircle.layer.shadowOpacity = 0.4
        
       
    }
    func updateIntakeValue(intakeQuantity : Int){
        let total = (UserDefaults.standard.integer(forKey: "totalInTakeValue") ) + intakeQuantity
        UserDefaults.standard.set(total, forKey: "totalInTakeValue")
        inTakeLabel.text = "\(total)/1200 ml"
    }
    @IBAction func homeBtn(_ sender: Any) {
        
    }
    
    @IBAction func historyBtn(_ sender: Any) {
    }
    
    @IBAction func settingsBtn(_ sender: Any) {
    }
    
    @objc func swapCups(){
        print("cup swapped")
        additionalCups =  AdditionalCups.init().get()
        print("additionalCups",additionalCups)
        handlePopUp()
    }
  
    func handlePopUp(){
        let currentWindow : UIWindow? = UIApplication.shared.keyWindow
        let screenSize = UIScreen.main.bounds
        
        backGroundView = UIView()
        backGroundView.frame = CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        backGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        currentWindow?.addSubview(backGroundView)
        
        let popupView = UIView()
        popupView.backgroundColor = UIColor.white
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        backGroundView.addSubview(popupView)
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 25),
            popupView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -25),
            popupView.centerXAnchor.constraint(equalTo: backGroundView.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: backGroundView.centerYAnchor)
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "Switch cups"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        popupView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 25)
        ])
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            closeButton.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 15),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        let collectionView = ContentSizedcollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: "chooseCup", bundle: nil), forCellWithReuseIdentifier: "chooseCup")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        popupView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
        
        let okButton = UIButton()
        okButton.setTitle("OK", for: .normal)
        okButton.setTitleColor(UIColor.black, for: .normal)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(okButton)
        NSLayoutConstraint.activate([
            okButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -25),
            okButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            okButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -10),
        ])
    }
    @objc func dismissPopup(){
        print("dismiss popup")
        backGroundView.isHidden = true
    }
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return additionalCups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chooseCup", for: indexPath) as! chooseCup
        let dict = additionalCups.object(at: indexPath.item)as! NSDictionary
        let imageName = dict.value(forKey: "image") as! String
        let quantity = dict.value(forKey: "quantity") as! String
        let isDeletable = dict.value(forKey: "isDeletable") as! Bool
        cell.quantityImage.image =  UIImage(named: imageName)
        cell.quantityLabel.text = quantity
        if isDeletable{
            cell.deleteCup.isHidden = false
        }else{
            cell.deleteCup.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 90, height: 90)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = additionalCups.object(at: indexPath.item) as! NSDictionary
        let renamedImage = "\(selectedData.value(forKey: "image") as! String)f"
        
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wdatas.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "DailyRecordCell", for: indexPath) as! DailyRecordCell
        
        let data = wdatas[indexPath.row]
        cell.timeLabel.text = data.time
        cell.quantityLabel.text = "\(data.value)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
