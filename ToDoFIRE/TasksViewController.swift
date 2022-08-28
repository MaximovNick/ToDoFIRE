//
//  TasksViewController.swift
//  ToDoFIRE
//
//  Created by Nikolai Maksimov on 26.08.2022.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss(animated: true)
    }
    
}


extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        
        
        var content = cell.defaultContentConfiguration()
        content.text = "This is cell number \(indexPath.row)"
        content.textProperties.color = .white
        
        cell.contentConfiguration = content
        
        return cell
    }
}
