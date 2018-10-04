//
//  ViewController.swift
//  Rent Calculator
//
//  Created by Omar U. Brito on 7/28/18.
//  Copyright © 2018 Omar U. Brito. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    var list = UserDefaults.standard.stringArray(forKey: "MyKey") ?? [String]()
    
    var ref: DatabaseReference!
    //MARK: Properties
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var eBillTextField: UITextField!
    @IBOutlet weak var eBillNameLabel: UILabel!
    @IBOutlet weak var eBillNumber: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var roommateTextField: UITextField!
    @IBOutlet weak var insuranceLabel: UILabel!
    @IBOutlet weak var insuranceTextField: UITextField!
    @IBOutlet weak var trueInsuranceLabel: UILabel!
    @IBOutlet weak var internetLabel: UILabel!
    @IBOutlet weak var internetTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    
    
    // MARK: Loaders
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        eBillTextField.delegate = self
        rentTextField.delegate = self
        insuranceTextField.delegate = self
        internetTextField.delegate = self
        ref = Database.database().reference()
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        
        if (screenHeight < 640){
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)
        }
        else {
            
            scrollView.contentSize = CGSize(width: screenWidth - 100, height: screenHeight)
        }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return (cell)
    
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            self.list.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    
    }

    
    @IBOutlet weak var h: UILabel!
    //MARK: UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the Keyboard
        textField.resignFirstResponder()
        return true
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var label = eBillNumber
        if (textField == rentTextField){
            label = h
        }
        if (textField == insuranceTextField){
            label = trueInsuranceLabel
        }
        
        if (textField == internetTextField){
            label = internetLabel
        }
        
        
        if let total = Double(textField.text!) {
            let listSize = Double(myTableView.numberOfRows(inSection: 0))
            let hello = total/listSize
            label?.text = (String(format: "%.02f", hello))
        }
    }
    //MARK: ACTIONS

    
    @IBAction func addRoommate(_ sender: Any) {
        
        if (roommateTextField.text != ""){
        list.append(roommateTextField.text!)
            roommateTextField.text = ""
            let defaults = UserDefaults.standard
            defaults.set(list, forKey: "MyKey")
            myTableView.reloadData()
    }
    }
    @IBAction func calculateTotal(_ sender: Any) {
        let totalArray = [eBillNumber.text!, trueInsuranceLabel.text!, internetLabel.text!, h.text!]
        print(totalArray)
        let strNumbersArray = totalArray.map{String(describing: $0)}
        print(strNumbersArray)
        let doublesArray = strNumbersArray.map{Double($0)!}
        print(doublesArray)
        let totalRent = (doublesArray.reduce(0, +))
        
            if Double(totalLabel.text!) != nil {
                totalLabel.text = (String(format: "%.02f", totalRent))
            }
        
        }
    
}
    


