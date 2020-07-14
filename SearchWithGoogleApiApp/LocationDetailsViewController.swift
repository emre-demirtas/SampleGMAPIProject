//
//  LocationDetailsViewController.swift
//  SearchWithGoogleApiApp
//
//  Created by mac on 14.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

//
//  MapViewController.swift
//  SearchWithGoogleApiApp
//
//  Created by mac on 14.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(selectedAdressArray[0].icon)
        print(selectedAdressArray[0].name)

        
        adressLabel.text = selectedAdressArray[0].formattedAddress
        latitudeLabel.text =  "Latitude: \(selectedAdressArray[0].lat)"
        longitudeLabel.text = "Longitude: \(selectedAdressArray[0].lng)"
        
        setImage(from: selectedAdressArray[0].icon)
        
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
}

