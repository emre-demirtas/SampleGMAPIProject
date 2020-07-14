//
//  VariablesHelper.swift
//  SearchWithGoogleApiApp
//
//  Created by mac on 14.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Result {
    var formattedAddress: String
    var lng: String
    var lat: String
    var userRatingsTotal: String
    var icon: String
    var name: String
}

var adressArray = [Result]()

var selectedAdressArray = [Result]()

let googleAPIKey = "AIzaSyBCmiAi-SgtYNvYzuwwCNjR2rFDtdoOKlo"
