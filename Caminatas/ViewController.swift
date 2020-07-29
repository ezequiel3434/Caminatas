//
//  ViewController.swift
//  Caminatas
//
//  Created by Ezequiel Parada Beltran on 29/07/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    lazy var dateFormatter: Formatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        return formatter
    }()
    
    var managedContext: NSManagedObjectContext!
    
    //var caminatas: [Date] = []
    
    var currentPerson: Person?
    
    
    
    
    
    // IVOutlets
    @IBOutlet weak var caminataTableVIew: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        caminataTableVIew.delegate = self
        caminataTableVIew.dataSource = self
        
        let personName = "Ezequiel"
        let personFetch: NSFetchRequest<Person> = Person.fetchRequest()
        personFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Person.name),personName)
        
        do {
            
 
            
            let resultados = try managedContext.fetch(personFetch)
            if resultados.count > 0 {
                // Se ha encontrado una persona con ese nombre
                currentPerson = resultados.first!
            } else {
                // NO se ha encontrado ninguan persona con ese nombre, vamos a crearla
                currentPerson = Person(context: managedContext)
                currentPerson?.name = personName
                
                try managedContext.save()
            }
        } catch let error as NSError{
            debugPrint("Ups, algo salió mal: \(error.localizedDescription)")
        }
        
    }

    @IBAction func addCaminata(_ sender: Any) {
        //caminatas.append(NSDate() as Date)
        
        // inseertar nueva caminata
    
        let caminata = CadaCaminata(context: managedContext)
        caminata.date = NSDate() as Date
        
        if let persona = currentPerson, let caminatas = persona.caminatas?.mutableCopy() as? NSMutableOrderedSet {
            caminatas.add(caminata)
            persona.caminatas = caminatas
        }
        
        // salvar toda la informacion
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("Algo salio mal: \(error.localizedDescription)")
        }
        
        
        caminataTableVIew.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let caminatas = currentPerson?.caminatas else { return 1 }
        
               
        
        return caminatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCaminatas", for: indexPath)

        guard let caminata = currentPerson?.caminatas?[indexPath.row] as? CadaCaminata,
            let fechaDeCaminata = caminata.date as? Date else { return cell }
        
        cell.textLabel?.text = dateFormatter.string(for: fechaDeCaminata)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let caminataAEliminar = currentPerson?.caminatas?[indexPath.row] as? CadaCaminata,
            editingStyle == .delete else { return  }
        
        managedContext.delete(caminataAEliminar)
        
        do {
            try managedContext.save()
            tableView.deleteRows(at: [indexPath] , with: .automatic)
        } catch let error as NSError {
            debugPrint("Ups, \(error.localizedDescription)")
        }
        
    }
    
    
}

