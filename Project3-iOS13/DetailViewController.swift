//
//  DetailViewController.swift
//  Project3-iOS13
//
//  Created by Dennis Nesanoff on 08.05.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var numberOfPicture: Int?
    var countOfPictures: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let selectedImage = selectedImage,
            let number = numberOfPicture,
            let count = countOfPictures {
            imageView.image = UIImage(named: selectedImage)
            title = "Picture \(number) of \(count)"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard
            let image = imageView.image?.jpegData(compressionQuality: 0.8),
            let name = selectedImage
            else {
                print("No image found")
                return
        }
        
        let activityVC = UIActivityViewController(activityItems: [image, name], applicationActivities: [])
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVC, animated: true)
    }
}
