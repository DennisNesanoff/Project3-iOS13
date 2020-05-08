//
//  ViewController.swift
//  Project3-iOS13
//
//  Created by Dennis Nesanoff on 08.05.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager()
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableViewDataSource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        dvc.selectedImage = pictures[indexPath.row]
        dvc.numberOfPicture = indexPath.row + 1
        dvc.countOfPictures = pictures.count
//        present(dvc, animated: true)
        navigationController?.pushViewController(dvc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
