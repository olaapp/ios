//
//  MapExtensions.swift
//  AESApp
//
//  Created by Alex on 5/25/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit

extension GMSMapView {
    func mapStyle(withFilename name: String, andType type: String) {
        do {
            if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}
