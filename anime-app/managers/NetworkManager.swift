//
//  NetworkManager.swift
//  anime-app
//
//  Created by Umesh Basnet on 02/04/2025.
//

import Foundation


class NetworkManager {
    
    
    func fetchHomePage(){
        
        let url = URL(string: Api.BASE_URL + Api.HOME)!;
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print("error")
                print(error!)
                return;
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invaid response")
                return;
            }
            
            if let data = data {
                var decoder = JSONDecoder()
                do {
                    let responseData = try decoder.decode(BaseWrapper.self, from: data)
                    if responseData.success {
                        print(responseData.results)
                    }
                } catch {
                    
                }
            }
            
            
        }
        
    }
    
}
