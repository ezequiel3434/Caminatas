//
//  ViewController.swift
//  Caminatas
//
//  Created by Ezequiel Parada Beltran on 29/07/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var dateFormatter: Formatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        return formatter
    }()
    
    var caminatas: [Date] = []
    
    
    
    // IVOutlets
    @IBOutlet weak var caminataTableVIew: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        caminataTableVIew.delegate = self
        caminataTableVIew.dataSource = self
        
    }

    @IBAction func addCaminata(_ sender: Any) {
        caminatas.append(NSDate() as Date)
        caminataTableVIew.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caminatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCaminatas", for: indexPath)
        cell.textLabel?.text = dateFormatter.string(for: caminatas[indexPath.row])
        
        return cell
    }
    
    
}

