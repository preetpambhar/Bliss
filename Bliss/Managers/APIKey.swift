//
//  APIKey.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-30.
//

import Foundation


enum APIKey{
    static var `default`: String {
        guard let filepath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else{
            fatalError("Could't find file 'GenerativeAI-Info.plist")
        }
        let plist = NSDictionary(contentsOfFile: filepath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else{
            fatalError("Could't find key 'API_Key in 'GenerativeAI_Info.plist'.")
        }
        if value.starts(with: "_"){
            fatalError("Follow the instruction at https://ai.google.dev/tutorials/setup to get an API Key.")
        }
        return value
    }
}
