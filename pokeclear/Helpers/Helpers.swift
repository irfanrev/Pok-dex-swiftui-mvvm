//
//  Helpers.swift
//  pokeclear
//
//  Created by Macbook on 26/08/23.
//

import Foundation

extension Bundle {
    func decode<T:Decodable>(file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Not found file in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Not found file in bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode")
        }
        
        return loadedData
    }
    
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (),
                                  failur:@escaping(Error) -> ()) {
        guard let url =  URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
        guard let data = data else {
            if let error = error {
                failur(error)
            }
            return
        }
        
        do {
            let serverData = try JSONDecoder().decode(T.self, from: data)
            completion(serverData)
        } catch {
            failur(error)
        }
    }
        .resume()
    }

}
