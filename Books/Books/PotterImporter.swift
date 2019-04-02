//
//  PotterImporter.swift
//  Books
//
//  Created by Lotanna Igwe-Odunze on 1/10/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

import Foundation

class Importer {
    
    static var shared = Importer() //Singleton for consistent reference

    var searchRef: SearchView!
    
    var character: Character? //To receive character data
    
    func grabHarry(query: String, completion: @escaping (Error?) -> Void) {
    
    let potterkey = "$2a$10$pkc3eVP9L312kS5TaMohiO085vIJr/w.G9glTKRDVpm1aVJT5pgWO"
    
    guard let potterAPI = URL(string: "https://www.potterapi.com/v1/characters?name=\(query)&key=\(potterkey)") else { return }
    
    //print(potterAPI) //Verification
    
    var request = URLRequest(url: potterAPI)
    
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
        
        if let error = error { //Assigns the standard error to a property so it can be customised.
            
            NSLog("Error: \(error.localizedDescription)") //Print the error description not just the standard error message
            
            completion(error) //Show error message in Debugger log.
            
            return
        }
        
        guard let potterData = data else { //Assigns the data that's fetched to a property for easy manipulation later.
            
            NSLog("Data was not recieved.") //Print this to the Debugger log if there's an error.
            
            completion(error) //Implement the error message if we fail to get data.
            
            return
        }
        
        do {
            
            let jsonDecoder = JSONDecoder() //Ease of use assignment.
            
            let grabbedWizards = try jsonDecoder.decode([Character].self, from: potterData) //Decode the data
            
            self.character = grabbedWizards.first //Assign the data
        
            completion(nil) //Set completion to nothing since decoding worked.
        }
        catch { //In case Decoding doesn't work.
            
            NSLog("Error: \(error.localizedDescription)")
            
            completion(error) //Show error message in Debugger log.
            
            return }
        
        }.resume() //Resumes the fetch function if it's been suspended e.g. because of errors.

    }//End of Grab Harry function.

}

