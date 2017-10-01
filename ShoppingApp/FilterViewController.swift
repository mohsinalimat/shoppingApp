//
//  FilterViewController.swift
//  ShoppingApp
//
//  Created by Damir Ramic on 01/10/2017.
//  Copyright © 2017 Damir Ramich. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var filterButton: UIButton! {
        didSet {
            filterButton .setTitle("FilterButtonTitle".localized(), for: .normal)
        }
    }
    @IBOutlet weak var amountSlider: UISlider!
    
    @IBOutlet weak var colorLabel: UILabel! {
        didSet {
            colorLabel.text = "ColorLabel".localized()
        }
    }
    @IBOutlet weak var amountLabel: UILabel! {
        didSet {
            amountLabel.text = "AmountLabel".localized()
        }
    }
    @IBOutlet weak var amountValue: UILabel!
    
    @IBOutlet weak var colorPickerTextField: UITextField!
    
    let pickerArray = ["black", "brown", "beige", "gray", "white", "blue", "petrol", "turquoise", "green", "olive","yellow","orange","red","pink","purple","gold", "silver","mulitcolored"]
    var selectedRow = 0
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        colorPickerTextField.inputView = pickerView
        // Do any additional setup after loading the view.
    }
    
    @IBAction func amountChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        DispatchQueue.main.async {
            self.amountValue.text = "\(value)"
        }
    }
    public func numberOfComponents(in pickerView:  UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedRow = row
        return pickerArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row;
        colorPickerTextField.text = pickerArray[row]
        self.view.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func filterActionPressed(_ sender: Any) {
        UserDefaults.standard.setValue("", forKey: "filterColor")
        UserDefaults.standard.setValue("", forKey: "filterAmount")
        
        if selectedRow > 0 {
            UserDefaults.standard.setValue(pickerArray[selectedRow], forKey: "filterColor")
        }
        
        if !(amountValue.text == "0") {
            UserDefaults.standard.setValue(amountValue.text, forKey: "filterAmount")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
