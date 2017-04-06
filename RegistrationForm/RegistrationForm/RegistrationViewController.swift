//
//  ViewController.swift
//  RegistrationForm
//
//  Created by Thien Chu on 4/6/17.
//  Copyright © 2017 Thien Chu. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderPickerView: UIPickerView!
    @IBOutlet var textFieldToolbar: UIToolbar!
    
    let genders = ["Male", "Female", "Not Telling"]
    
    var textFields:Array<UITextField> {
        return [self.firstNameTextField, self.lastNameTextField, self.phoneNumberTextField, self.genderTextField, dobTextField]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTextFields()
        updateSubmitButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelItemDidTouched(_ sender: Any) {
        resignPickerView()
        
        if phoneNumberTextField.isFirstResponder {
            phoneNumberTextField.text = ""
            phoneNumberTextField.resignFirstResponder()
        }
    }
    
    @IBAction func doneItemDidTouched(_ sender: Any) {
        if dobTextField.isFirstResponder {
            dobTextField.text = String(format: "\(datePicker.date)")
        }
        else if genderTextField.isFirstResponder {
            genderTextField.text = genders[genderPickerView.selectedRow(inComponent: 0)]
        }
        else if phoneNumberTextField.isFirstResponder {
            phoneNumberTextField.resignFirstResponder()
        }
        
        resignPickerView()
        
        updateSubmitButtonState()
    }
    
    fileprivate func setupTextFields() {
        dobTextField.inputView = datePicker
        dobTextField.inputAccessoryView = textFieldToolbar
        datePicker.removeFromSuperview()
        
        genderTextField.inputView = genderPickerView
        genderTextField.inputAccessoryView = textFieldToolbar
        genderPickerView.removeFromSuperview()
        
        phoneNumberTextField.inputAccessoryView = textFieldToolbar
    }
    
    fileprivate func resignPickerView() {
        if dobTextField.isFirstResponder {
            dobTextField.resignFirstResponder()
            return
        }
        genderTextField.resignFirstResponder()
    }
    
    func updateSubmitButtonState() {
        let isEnabled = textFields.reduce(true) { (result, textField) -> Bool in
            let text = textField.text ?? ""
            return result && (text.characters.count > 0)
        }
        submitButton.isEnabled = isEnabled
    }
}

extension RegistrationViewController: UIPickerViewDelegate {
    
}

extension RegistrationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateSubmitButtonState()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSubmitButtonState()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

