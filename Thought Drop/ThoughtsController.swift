//
//  ThoughtsController.swift
//  Thought Drop
//
//  Created by Oliver  on 2/17/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import UIKit
import CoreLocation

class ThoughtController: UITableViewController {
    
    let IDENTIFIER = "Thoughts"
    var thoughts = [Thought]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coord = CLLocationCoordinate2DMake(0.0, 0.0)
        let example = Thought(title: "test", coordinate: coord)
        thoughts.append(example)
    }
}


// MARK: - TableView set up
extension ThoughtController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER, for: indexPath)
        let thought = thoughts[indexPath.row]
        cell.textLabel?.text = thought.title
        return cell
    }
}
