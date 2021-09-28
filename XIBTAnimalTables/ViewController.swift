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
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "XIBNameCell", for: indexPath) as! XIBNameCell
        cell.lbl.text = animals[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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

