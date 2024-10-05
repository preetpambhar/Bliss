//
//  LocationSearchViewModel.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-03.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject{
    //MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet{
            //print("DEBUG: Query fragment is \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: - Helpers
    func selectedLocation(_ localSearch: MKLocalSearchCompletion){
//        self.selectedLocation = location
//        print("DEBUG: Selected location \(self.selectedLocation)")
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed \(error.localizedDescription)")
                return
            }
            guard let item  = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("DEBUG: location coordinate :\(coordinate)")
        }
        
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
}

//MARK: -  MKLocalSearchCompleterDelegate

extension LocationSearchViewModel:MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
