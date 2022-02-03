//
//  ViewController.swift
//  ECalculator
//
//  Created by Admin on 09.01.2022.
//

import UIKit


class OhmLawViewController: UIViewController {

    var ohmLawCalculator = Calculator()
    
    //MARK: - property
    //Если меняем любую характеристику, то должна вычисляться новая мощность. Если мы меняем мощность, то должно вычисляться новое сопротивление.
    @IBOutlet var currentStrengthTextField: UITextField!
    @IBOutlet var voltageTextField: UITextField!
    @IBOutlet var resistanceTextField: UITextField!
    @IBOutlet var powerTextField: UITextField!
    @IBOutlet var selectionCurrent: UIButton!
    @IBOutlet var selectionVoltage: UIButton!
    @IBOutlet var selectionResistance: UIButton!
    //Предупреждает о некорректности ввода
    @IBOutlet var warningLabel: UILabel!


    var result: Targets!
    
    let imageNotSelection = UIImage(systemName: "arrow.right.circle")
    let imageSelection = UIImage(systemName: "arrow.right.circle.fill")
    let imageInformation = UIImage(named: "info.circle")
    
    var clickForSwitch: Bool = true


//    func createInformationButton() -> UIButton {
//        let informationButton = UIButton()
//        informationButton.frame = CGRect(x: view.safeAreaInsets.right - 80, y: view.safeAreaInsets.top + 500, width: 34, height: 28)
//        informationButton.layer.cornerRadius = 2
//        informationButton.setImage(imageInformation, for: UIControl.State.normal)
//        informationButton.addTarget(self, action: #selector(goToTheInformationView), for: UIControl.Event.touchUpInside)
//        return informationButton
//    }
    
    @objc func goToTheInformationView() {
        let informationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InformationViewController")
        self.navigationController?.pushViewController(informationViewController, animated: true)
    }
    
    
    //MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageOnTheButtons()
        setStartValueForTextField()
        configurateTextFields()
//        view.addSubview(createInformationButton())
    }
    
//    func setConstraints() {
//    self.informationButton.snp.makeConstraints { make in
//        make.right.equalTo(view).offset(20)
//    }
//    }
 
    func setStartValueForTextField() {
    currentStrengthTextField.text = "0"
    voltageTextField.text = "0"
    resistanceTextField.text = "0"
    powerTextField.text = "0"
    }
    
    func configurateTextFields() {
        currentStrengthTextField.keyboardType = .decimalPad
        voltageTextField.keyboardType = .decimalPad
        resistanceTextField.keyboardType = .decimalPad
        powerTextField.keyboardType = .decimalPad
    }
        
    @IBAction func currentStrengthHasChangedTextField(_ sender: UITextField) {
        updateSpecifications()
        ohmLawCalculator.calculateCharacteristics()
        voltageTextField.text = getStringFrom(number: ohmLawCalculator.targets.voltage)
        resistanceTextField.text = getStringFrom(number: ohmLawCalculator.targets.resistance)
        powerTextField.text = getStringFrom(number: ohmLawCalculator.targets.power)
    }
    
    @IBAction func voltageHasChangedTextField(_ sender: UITextField) {
        sender.keyboardType = .decimalPad
        updateSpecifications()
        ohmLawCalculator.calculateCharacteristics()
        currentStrengthTextField.text = getStringFrom(number: ohmLawCalculator.targets.current)
        resistanceTextField.text = getStringFrom(number: ohmLawCalculator.targets.resistance)
        powerTextField.text = getStringFrom(number: ohmLawCalculator.targets.power)
    }
    
    @IBAction func resistanceHasChangedTextField(_ sender: UITextField) {
        sender.keyboardType = .decimalPad
        updateSpecifications()
        ohmLawCalculator.calculateCharacteristics()
        currentStrengthTextField.text = getStringFrom(number: ohmLawCalculator.targets.current)
        voltageTextField.text = getStringFrom(number: ohmLawCalculator.targets.voltage)
        powerTextField.text = getStringFrom(number: ohmLawCalculator.targets.power)
    }
    
    @IBAction func powerHasChangedTextField(_ sender: UITextField) {
        sender.keyboardType = .decimalPad
        updateSpecifications()
        ohmLawCalculator.powerHasChanged()
//        ohmLawCalculator.calculateCharacteristics()
        currentStrengthTextField.text = getStringFrom(number: ohmLawCalculator.targets.current)
        voltageTextField.text = getStringFrom(number: ohmLawCalculator.targets.voltage)
        resistanceTextField.text = getStringFrom(number: ohmLawCalculator.targets.resistance)
    }
        
    //Преобразуем число в строку
    func getStringFrom(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesSignificantDigits = true
        numberFormatter.allowsFloats = true
        numberFormatter.maximumFractionDigits = 2
        let stringNumber = numberFormatter.string(from: NSNumber.init(value: number)) ?? ""
        return stringNumber
    }
    
    //Обновление текстфилдов
    func updateTextField() {
        currentStrengthTextField.text = getStringFrom(number: ohmLawCalculator.targets.current)
        voltageTextField.text = getStringFrom(number: ohmLawCalculator.targets.voltage)
        resistanceTextField.text = getStringFrom(number: ohmLawCalculator.targets.resistance)
        powerTextField.text = getStringFrom(number: ohmLawCalculator.targets.power)
    }
    
    //Для того, чтобы корректно велся расчет в модели необходимо запятую менять на точку
    func replaceCommaWithPeriod(from string: String?) -> String {
        let valueFromTextField = string ?? ""
        let valueWithoutComma = String(valueFromTextField.map{ $0 == "," ? "." : $0 })
        return valueWithoutComma
    }
    
    //Метод, с помощью которого обновляем данные модели
    func updateSpecifications() {
        ohmLawCalculator.targets.current = Double(replaceCommaWithPeriod(from: currentStrengthTextField.text)) ?? 0
        ohmLawCalculator.targets.voltage = Double(replaceCommaWithPeriod(from: voltageTextField.text)) ?? 0
        ohmLawCalculator.targets.resistance = Double(replaceCommaWithPeriod(from: resistanceTextField.text)) ?? 0
        ohmLawCalculator.targets.power = Double(replaceCommaWithPeriod(from: powerTextField.text)) ?? 0
    }
    
    
    func selectionCheck() {
        if selectionCurrent.image(for: UIControl.State.normal) == imageNotSelection && selectionVoltage.image(for: UIControl.State.normal) == imageNotSelection && selectionResistance.image(for: UIControl.State.normal) == imageNotSelection {
            UIView.animate(withDuration: 0.3) {
                self.warningLabel.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.warningLabel.alpha = 0
            }
        }
    }
    
    
    
    @IBOutlet var arrayButtons: [UIButton]!
    func changeImageOnTheButtons() {
        for button in arrayButtons {
            if button.isTouchInside {
                button.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: UIControl.State.normal)
            } else {
                button.setImage(UIImage(systemName: "arrow.right.circle"), for: UIControl.State.normal)
            }
        }
    }
    
    
    @IBAction func selectionCurrentButton(_ sender: UIButton) {
        if sender.image(for: UIControl.State.normal) == imageNotSelection {
            changeImageOnTheButtons()
            ohmLawCalculator.selectionC = true
            ohmLawCalculator.selectionV = false
            ohmLawCalculator.selectionR = false
            updateSpecifications()
            selectionCheck()
            ohmLawCalculator.calculateCharacteristics()
            updateTextField()
        } else {
            selectionCurrent.setImage(UIImage(systemName: "arrow.right.circle"), for: UIControl.State.normal)
            ohmLawCalculator.selectionC = false
            selectionCheck()
        }
        
    }
        
    @IBAction func selectionVoltageButton(_ sender: UIButton) {
        if sender.currentImage == imageNotSelection {
            changeImageOnTheButtons()
            ohmLawCalculator.selectionC = false
            ohmLawCalculator.selectionV = true
            ohmLawCalculator.selectionR = false
            updateSpecifications()
            selectionCheck()
            ohmLawCalculator.calculateCharacteristics()
            updateTextField()
        } else {
            selectionVoltage.setImage(UIImage(systemName: "arrow.right.circle"), for: UIControl.State.normal)
            ohmLawCalculator.selectionV = false
            selectionCheck()
        }
    }
    
    @IBAction func selectionResistanceButton(_ sender: UIButton) {
        if sender.currentImage == imageNotSelection {
            changeImageOnTheButtons()
            ohmLawCalculator.selectionC = false
            ohmLawCalculator.selectionV = false
            ohmLawCalculator.selectionR = true
            updateSpecifications()
            selectionCheck()
            ohmLawCalculator.calculateCharacteristics()
            updateTextField()
        } else {
            selectionResistance.setImage(UIImage(systemName: "arrow.right.circle"), for: UIControl.State.normal)
            ohmLawCalculator.selectionR = false
            selectionCheck()
        }
    }
    
    func setImageOnTheButtons() {
        selectionCurrent.setImage(UIImage(systemName: "arrow.right.circle"), for: UIControl.State.normal)
        selectionCurrent.setTitle("", for: UIControl.State.normal)
        selectionVoltage.setImage(UIImage(systemName: "arrow.right.circle"), for: UIControl.State.normal)
        selectionVoltage.setTitle("", for: UIControl.State.normal)
        selectionResistance.setImage(UIImage(systemName: "arrow.right.circle"), for: UIControl.State.normal)
        selectionResistance.setTitle("", for: UIControl.State.normal)
    }
}
