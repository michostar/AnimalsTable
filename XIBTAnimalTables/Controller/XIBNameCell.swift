//
//  XIBNameCell.swift
//  XIBTAnimalTables
//
//  Created by Michael Shoukry on 9/28/21.
//

import UIKit


protocol XIBNameCellDelegate: AnyObject{
    func cellIsUp(name: String?)
    func cellIsDown(name: String?)
}

class XIBNameCell: UITableViewCell {

   weak var delgateChangeCells: XIBNameCellDelegate!
    
    
    
    var texts = ""
    @IBOutlet weak var lbl: UILabel!
    
    func labelName(){
        texts = lbl.text!
    }
    
    
    @IBAction func groupBtn(_ sender: UIButton) {
        labelName()
        print("Group of \(texts) is pressed")
        delgateChangeCells.cellIsUp(name: lbl.text)
        
        
    }
    @IBAction func soloBtn(_ sender: UIButton) {
        labelName()
        print("Solo of \(texts) is pressed")
        delgateChangeCells.cellIsDown(name: lbl.text)
    }
}
