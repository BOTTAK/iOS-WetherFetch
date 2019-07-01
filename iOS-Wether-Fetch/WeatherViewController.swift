//
//  ViewController.swift
//  iOS-Wether-Fetch
//
//  Created by BOTTAK on 6/29/19.
//  Copyright © 2019 BOTTAK. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var forecastData = [Weather]()
    var time: Date?
    var managedObjectContext: NSManagedObjectContext!
    
//    lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<NSFetchRequestResult> in
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
//
//
//        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//
//
//        fetchedResultsController.delegate = self as! NSFetchedResultsControllerDelegate
//
//        return fetchedResultsController
//    }()
//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        updateWeatherForLocation(location: "Minsk")
//        print(managedObjectContext!)
        
//        do {
//            try self.fetchedResultsController.performFetch()
//        } catch {
//            let fetchError = error as NSError
//            print("\(fetchError), \(fetchError.userInfo)")
//        }
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            updateWeatherForLocation(location: locationString)
        }
        
    }
    
    func updateWeatherForLocation (location:String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    Weather.forecast(withLocation: location.coordinate, completion: { (results:[Weather]?) in
                        
                        if let weatherData = results {
                            self.forecastData = weatherData
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    })
                }
            }
        }
    }
    
    func autoUpdate() {
        time = Date()
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
//    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        switch {
//        case .update:
//            if let indexPath = indexPath {
//                let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WeatherCell
//                cell(cell, atIndexPath: indexPath)
//
//            }
//            break;
//
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastData.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        return dateFormatter.string(from: date!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let weatherObject = forecastData[indexPath.section]
        cell.titleLabel?.text = weatherObject.summary
        cell.subtitleLabel?.text = "\(Int(weatherObject.temperature)) °F"
//        cell.imageView?.image = UIImage(named: weatherObject.icon)
        
        return cell
    }
    
    
}

