//
//  ViewController.swift
//  XIBTAnimalTables
//
//  Created by Michael Shoukry on 9/28/21.
//

import UIKit

class ViewController: UITableViewController {
    
    
    
    var animals:[AnimalsName] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.s
        getData {
            self.tableView.reloadData()
        }
        tableView.register(UINib(nibName: "XIBNameCell", bundle: nil), forCellReuseIdentifier: "XIBNameCell")
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if animals[indexPath.row].cellNum == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "XIBNameCell", for: indexPath)as! XIBNameCell
        cell.lbl.text = animals[indexPath.row].name
            cell.delegateReload = self
            return cell
        }else
        {
            let cell = Bundle.main.loadNibNamed("DescriptionCell", owner: self, options: nil)?.first as! DescriptionCell
            cell.descripeLbl.text = animals[indexPath.row].description
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
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

extension ViewController: ReloadTableDelegate{
    func reloadTable() {
        print("Reloading....")
    }
}

