//
//  ViewController.swift
//  XIBTAnimalTables
//
//  Created by Michael Shoukry on 9/28/21.
//

import UIKit

class ViewController: UITableViewController, XIBNameCellDelegate {
    
    
    var indexPath: IndexPath?
    var animals:[AnimalsName] = []
    var descriptions: [Description] = []
    var height: CGFloat = 50
    
    
    func cellIsUp(name: String?) {
        (height == 50) ? (height = 100) :(height = 50)
        tableView.reloadData()
        tableView.beginUpdates()

        tableView.moveRow(at: IndexPath(row: 0, section: 0), to: IndexPath(row: 1, section: 0))
        tableView.moveRow(at: IndexPath(row: 2, section: 0), to: IndexPath(row: 3, section: 0))
        tableView.moveRow(at: IndexPath(row: 4, section: 0), to: IndexPath(row: 5, section: 0))
        
//        let row = indexPath?.row
//        switch (row){
//            case 0: tableView.moveRow(at: IndexPath(row: 0, section: 0) , to: IndexPath(row: 1, section: 0))
//            case 2 :tableView.moveRow(at: IndexPath(row: 2, section: 0) , to: IndexPath(row: 3, section: 0))
//            default:tableView.moveRow(at: IndexPath(row: 0, section: 0) , to: IndexPath(row: 1, section: 0))
//        }
        tableView.endUpdates()
        
        //        tableView.reloadData()
        print("Up")
    }
    
    func cellIsDown(name: String?) {
        
        print("Down")
    }
    
    weak var delgateChangeCells: XIBNameCellDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData {
            self.tableView.reloadData()
        }
        tableView.register(UINib(nibName: "XIBNameCell", bundle: nil), forCellReuseIdentifier: "XIBNameCell")
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? animals.count : descriptions.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "XIBNameCell", for: indexPath)as! XIBNameCell
            print("\(indexPath.row)   &&  \(indexPath.section) && \(indexPath.description)")
            
            cell.lbl.text = animals[indexPath.row].name
            cell.delgateChangeCells = self
            return cell
        }else if indexPath.row % 2 == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)as! DescriptionCell
            cell.descripeLbl.text = descriptions[indexPath.row].description
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath)as! DescriptionCell
            cell.descripeLbl.text = descriptions[indexPath.row].description
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
        if let path = Bundle.main.path(forResource: "Description", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                descriptions = try JSONDecoder().decode([Description].self, from: data)
            }catch let error{
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}



