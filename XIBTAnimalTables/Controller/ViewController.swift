//
//  ViewController.swift
//  XIBTAnimalTables
//
//  Created by Michael Shoukry on 9/28/21.
//

import UIKit

class ViewController: UITableViewController, ChangeCells{
    
    
    func cellIsUp() {
        var cells = AnimalsName()
        cells.cellNum = 1
        self.tableView.reloadData()
        print(cells)
    }
    
    func cellIsDown() {
        var cellNumbers = AnimalsName()
            cellNumbers.cellNum = 2
        self.tableView.reloadData()
        print(cellNumbers)
    }
    
    var indexPath: IndexPath?
    var animals:[AnimalsName] = []
    
    weak var delgateChangeCells: ChangeCells!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.s
        getData {
            self.tableView.reloadData()
        }
        tableView.register(UINib(nibName: "XIBNameCell", bundle: nil), forCellReuseIdentifier: "XIBNameCell")
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        
//        tableView.isEditing = true
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if animals[indexPath.row].cellNum == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "XIBNameCell", for: indexPath)as! XIBNameCell
            cell.lbl.text = animals[indexPath.row].name
            cell.delgateChangeCells = self
            return cell
            
        }else if animals[indexPath.row].cellNum == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)as! DescriptionCell
            cell.descripeLbl.text = animals[indexPath.row].description
            cell.delgateChangeCells = self
            
            return cell
        }else{
            let cell = Bundle.main.loadNibNamed("DescriptionCell", owner: self, options: nil)?.first as! DescriptionCell
            cell.descripeLbl.text = animals[indexPath.row].description
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
//
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .none
//    }
//
//    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let move = self.animals[sourceIndexPath.row]
//        animals.remove(at: sourceIndexPath.row)
//        animals.insert(move, at: destinationIndexPath.row)
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.animals[indexPath.row].cellNum == 1
        {
            self.animals[indexPath.row].cellNum = 2
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        else if self.animals[indexPath.row].cellNum == 2
        {
            self.animals[indexPath.row].cellNum = 1
            tableView.reloadRows(at: [indexPath], with: .right)
        }
    }
    
    // get data from JSON
    func getData( completed:@escaping () -> ()){
        if let path = Bundle.main.path(forResource: "Data", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                animals = try JSONDecoder().decode([AnimalsName].self, from: data)
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
}



