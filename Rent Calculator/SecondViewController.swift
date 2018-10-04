//
//  SecondViewController.swift
//  Rent Calculator
//
//  Created by Omar U. Brito on 9/2/18.
//  Copyright © 2018 Omar U. Brito. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SecondViewController: UIViewController {
    
    
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var eBill: UILabel!
    @IBOutlet weak var baseRent: UILabel!
    @IBOutlet weak var insuranceBill: UILabel!
    @IBOutlet weak var internetBill: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ref = Database.database().reference()
        
            ref.child("rents").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                self.eBill.text = (postDict["electricity"]! as! String)
                self.baseRent.text = (postDict["base_rent"]! as! String)
                self.insuranceBill.text = (postDict["insurance"]! as! String)
                self.internetBill.text = (postDict["internet"]! as! String)
                
        })
        
    
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
