//
//  ViewController.swift
//  SearchWithGoogleApiApp
//
//  Created by mac on 14.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import SnapKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewSetup()
        searchBar.delegate = self
        
    }
    
    func viewSetup(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white
        
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset((self.searchBar.frame.height) + 20)
        }
        
        self.searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset(25)
        }
    }
    
    func googleApiTextSearch(adress:String){
        
        adressArray.removeAll()
        let urlString =     "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(adress)&key=\(googleAPIKey)"
        let urlStringg = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStringg!)
        
        Alamofire.request(url!, method: .get, headers: nil)
            .validate()
                .responseJSON {
                    (response) in
                    switch response.result {
                        case.success(let value):
                            let json = JSON(value)
                            
                            for i in 0...json["results"].array!.count {
                                adressArray.append(Result(
                                    formattedAddress: json["results"][i]["formatted_address"].rawString()!,
                                    lng: json["results"][i]["geometry"]["location"]["lng"].rawString()!,
                                    lat: json["results"][i]["geometry"]["location"]["lat"].rawString()!,
                                    userRatingsTotal: json["results"][i]["user_ratings_total"].rawString()!,
                                    icon: json["results"][i]["icon"].rawString()!,
                                    name: json["results"][i]["name"].rawString()!
                                ))
                                self.tableView.reloadData()
                            }
                            self.dismiss(animated: true, completion: nil)
        
                    case.failure(let error):
                        print("\(error.localizedDescription)")
                    }
               }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if adressArray.count > indexPath.row + 1 {
            let result = adressArray[indexPath.row]
            
            if (result.formattedAddress != "null"){
                cell.textLabel?.text = result.formattedAddress
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let result = adressArray[indexPath.row]
        
        if (result.lat == "null" || result.lng == "null" ){
            let alert = UIAlertController(title: "Alert", message: "Please do a more detailed search", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            print("asdasdasd")
            
            selectedAdressArray.append(
                Result(
                    formattedAddress: result.formattedAddress,
                    lng: result.lng,
                    lat: result.lat,
                    userRatingsTotal: result.userRatingsTotal,
                    icon: result.icon,
                    name: result.name
            ))
            
            adressArray.removeAll()
            self.tableView.reloadData()
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            self.present(nextViewController, animated:true, completion:nil)
            
          
        }
    
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText != ""){
            googleApiTextSearch(adress: searchText)
        }
        else{
            adressArray.removeAll()
            self.tableView.reloadData()
        }
    }

}
