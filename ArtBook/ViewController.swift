//
//  ViewController.swift
//  ArtBook
//
//  Created by ismail harmanda on 26.10.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    class Painting {
    var id: UUID?
    var name: String?
    }
    var items = [Painting]()
    
    @objc func getData(){
        
        items.removeAll(keepingCapacity: true)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Painting")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
        
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    if let id = result.value(forKey: "id") as? UUID {
                        let newPainting = Painting()
                        newPainting.id = id
                        newPainting.name = name
                        items.append(newPainting)
                    }
                }
                
            }
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        
        content.text = items[indexPath.row].name
        
        cell.contentConfiguration = content
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToDetailVC))
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue:"newData"), object:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewDetailVC" {
            var destinationVC = segue.destination as! DetailVC
            destinationVC.test = "deneme"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    @objc func navigateToDetailVC (){
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }


}

