//
//  ViewController.swift
//  The_Reminder
//
//  Created by Ashok on 04/01/24.
//

import UIKit

class tabVC: UITabBarController,UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
        self.delegate = self
    }
}
class ViewController: UIViewController {
    
    
    @IBOutlet weak var brokenHeart: UIImageView!
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
    
    var textField1 = UITextField()
    let shapeLayer = CAShapeLayer()
    var wdatas : [tableData] = []
    var additionalCups:[cup] = []
    var backGroundView = UIView()
    var collectionView = ContentSizedcollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let vm = ViewModel()
    var previousOption: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "DailyRecordCell", bundle: nil), forCellReuseIdentifier: "DailyRecordCell")
        textField1.delegate = self
        
        let userDefaults1 = UserDefaults.standard
        if userDefaults1.value(forKey: "OnboardingFronScreen") == nil {
            userDefaults1.set(true, forKey: "OnboardingFronScreen")
            //            let storyboard = UIStoryboard(name: "OnboardingViewController", bundle: nil)
            //            if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            //                present(walkthroughViewController, animated: true, completion: nil)
            //
            //            }
        }
        //
        vm.getValue{
            datas,total  in
            UserDefaults.standard.set(total, forKey: "totalInTakeValue")
            self.wdatas = datas
            self.tableView.reloadData()
        }
        setupUI()
        drawSemiCircle()
        updateIntakeValue(intakeQuantity: 0)
//        graphViewModel().getCurrentMonthData()
    }
    
    @IBAction func addDailyTarget(_ sender: Any) {
        addMissingTarget()
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
            datas,total  in
            UserDefaults.standard.set(total, forKey: "totalInTakeValue")
            self.wdatas = datas
            self.tableView.reloadData()
        }
        animateLabel.transform = .identity
        
        let quantity = UserDefaults.standard.integer(forKey: "selectedCup")
        animateLabel.text = "+\(quantity) Well done"
        updateIntakeValue(intakeQuantity: quantity)
        
        UIView.animate(withDuration: 1.5){
            self.animateLabel.alpha = 1
            self.animateLabel.transform = CGAffineTransform(translationX: 0, y: -50)
            self.animateLabel.alpha = 0
        }
    }
    func setupUI(){
        
        brokenHeart.tintColor = .lightGray
        
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
        let totalQuans = UserDefaults.standard.integer(forKey: "totalQuans")
        let total = UserDefaults.standard.integer(forKey: "totalInTakeValue")
        inTakeLabel.text = "\(total)/\(totalQuans) ml"
    }
    @objc func swapCups(){
        print("cup swapped")
        additionalCups =  AdditionalCups.init().get()
        print("additionalCups",additionalCups)
        handlePopUp()
    }
    
    func handlePopUp(){
        let screenSize = UIScreen.main.bounds
        
        backGroundView = UIView()
        backGroundView.frame = CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        backGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(backGroundView)
        
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
        
        collectionView = ContentSizedcollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        okButton.addTarget(self, action: #selector(confirmAct), for: .touchUpInside)
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
        if previousOption != ""{
            UserDefaults.standard.setValue(previousOption, forKey: "selectedCup")
        }
        previousOption = ""
        backGroundView.isHidden = true
    }
    @objc func confirmAct(){
        previousOption = ""
        backGroundView.isHidden = true
    }
    func addMissingTarget(){
        let screenSize = UIScreen.main.bounds
        
        backGroundView = UIView()
        backGroundView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        backGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(backGroundView)
        
        let backView = UIView()
        backView.backgroundColor = UIColor.white
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        backGroundView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -10),
            backView.centerXAnchor.constraint(equalTo: backGroundView.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: backGroundView.centerYAnchor)
        ])
        
        let instructionLabel = UILabel()
        instructionLabel.text = "Add a record of drinking water in the past that you forgot to confirm"
        instructionLabel.numberOfLines = 0
        instructionLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        backView.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            instructionLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            instructionLabel.topAnchor.constraint(equalTo: backView.topAnchor,constant: 20)
        ])
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: instructionLabel.topAnchor,constant: 25),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            //stackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor,constant: -10)
        ])
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        if #available(iOS 15, *) {
            datePicker.maximumDate = .now
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        stackView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            //datePicker.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            datePicker.topAnchor.constraint(equalTo: stackView.topAnchor,constant: 10),
            datePicker.bottomAnchor.constraint(equalTo: stackView.bottomAnchor,constant: -10),
            datePicker.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        let image = UIImageView()
        image.image = UIImage(named: "150f")
        image.tintColor = hexStringToUIColor(hex: "#0ACBFF")
        image.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: 20),
            image.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 25),
            image.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        textField1 = UITextField()
        textField1.borderStyle = .line
        textField1.keyboardType = .numberPad
        textField1.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(textField1)
        NSLayoutConstraint.activate([
            textField1.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            textField1.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            textField1.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let mlLbl = UILabel()
        mlLbl.text = "ml"
        mlLbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        mlLbl.textColor = hexStringToUIColor(hex: "#0ACBFF")
        mlLbl.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(mlLbl)
        NSLayoutConstraint.activate([
            mlLbl.leadingAnchor.constraint(equalTo: textField1.trailingAnchor, constant: 10),
            mlLbl.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            mlLbl.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor),
            mlLbl.heightAnchor.constraint(equalToConstant: 30),
            mlLbl.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        let confirmBtn = UIButton()
        confirmBtn.titleLabel?.text = "OK"
        confirmBtn.setTitleColor(hexStringToUIColor(hex: "#0ACBFF"), for: .normal)
        confirmBtn.setTitle("OK", for: .normal)
        confirmBtn.translatesAutoresizingMaskIntoConstraints = false
        confirmBtn.addTarget(self, action: #selector(confirmAddOn), for: .touchUpInside)
        backView.addSubview(confirmBtn)
        NSLayoutConstraint.activate([
            confirmBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            confirmBtn.trailingAnchor.constraint(equalTo: backView.trailingAnchor,constant: -20),
            confirmBtn.widthAnchor.constraint(equalToConstant: 40),
            confirmBtn.heightAnchor.constraint(equalToConstant: 40),
            confirmBtn.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10)
        ])
        
        let deleteBtn = UIButton()
        deleteBtn.titleLabel?.text = "Cancel"
        deleteBtn.setTitleColor(UIColor.lightGray, for: .normal)
        deleteBtn.setTitle("Cancel", for: .normal)
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.addTarget(self, action: #selector(cancelAdOn), for: .touchUpInside)
        backView.addSubview(deleteBtn)
        NSLayoutConstraint.activate([
            deleteBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            deleteBtn.trailingAnchor.constraint(equalTo: confirmBtn.leadingAnchor,constant: -15),
            deleteBtn.widthAnchor.constraint(equalToConstant: 70),
            deleteBtn.heightAnchor.constraint(equalToConstant: 40),
            deleteBtn.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10)
        ])
    }
    @objc func confirmAddOn(){
        
        textField1.resignFirstResponder()
        let quantity = Int(textField1.text ?? "0") ?? 0
        if quantity == 0{
            
        }else{
            backGroundView.isHidden = true
            vm.addValue(quantity: quantity)
            vm.getValue{
                datas,total  in
                UserDefaults.standard.set(total, forKey: "totalInTakeValue")
                self.wdatas = datas
                self.tableView.reloadData()
            }
            updateIntakeValue(intakeQuantity: quantity)
        }

        
    }
    
    @objc func cancelAdOn(){
        textField1.resignFirstResponder()
        backGroundView.isHidden = true
    }
}
extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let currentText = textField1.text,
//                        let range = Range(range, in: currentText) else {
//                      return false
//                  }
//        let updatedText = currentText.replacingCharacters(in: range, with: string)
//                  
//                  // Limit the text field to numeric characters only
//        let allowedCharacters = CharacterSet.decimalDigits
//                  let characterSet = CharacterSet(charactersIn: string)
//                  return allowedCharacters.isSuperset(of: characterSet) && updatedText.count <= 3
//    }
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return additionalCups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chooseCup", for: indexPath) as! chooseCup
        let dict = additionalCups[indexPath.item]
        let Selectedimage = UserDefaults.standard.string(forKey: "selectedCup")
        
        if Selectedimage == dict.image{
            cell.quantityImage.image =  UIImage(named: "\(dict.image)f")
            cell.quantityImage.tintColor = hexStringToUIColor(hex: "#568ce3")
        }else{
            cell.quantityImage.image =  UIImage(named: dict.image)
            cell.quantityImage.tintColor = hexStringToUIColor(hex: "#000000")
        }
        cell.quantityLabel.text = dict.quantity
        if dict.isDeletable{
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
        let selectedData = additionalCups[indexPath.item].image
        previousOption = UserDefaults.standard.string(forKey: "selectedCup") ?? ""
        UserDefaults.standard.setValue(selectedData, forKey: "selectedCup")
        collectionView.reloadData()
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
