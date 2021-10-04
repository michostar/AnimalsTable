//
//  XIBNameCell.swift
//  XIBTAnimalTables
//
//  Created by Michael Shoukry on 9/28/21.
//

import UIKit


protocol ChangeCells: AnyObject{
    func cellIsUp(cell: Int)
    func cellIsDown()
    
}

class XIBNameCell: UITableViewCell {

    var delgateChangeCells: ChangeCells!
    
    var texts = ""
    @IBOutlet weak var lbl: UILabel!
    
    func labelName(){
        texts = lbl.text!
    }
    
    
    @IBAction func groupBtn(_ sender: UIButton) {
        labelName()
        print("Group of \(texts) is pressed")
        delgateChangeCells.cellIsUp(cell: 2)
        
        
    }
    @IBAction func soloBtn(_ sender: UIButton) {
        labelName()
        print("Solo of \(texts) is pressed")
        delgateChangeCells.cellIsDown()
    }
}
