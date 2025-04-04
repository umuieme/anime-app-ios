//
//  NetworkManager.swift
//  anime-app
//
//  Created by Umesh Basnet on 02/04/2025.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager();
    
    var homeDataFetchDelegate: HomeDataFetchDelegate?;
    
    func fetchHomePage() {
        
        let url = URL(string: Api.BASE_URL + Api.HOME)!;
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print("error")
                print(error!)
                DispatchQueue.main.async {
                    self.homeDataFetchDelegate?.didFailWithError(error: error?.localizedDescription ?? "Something went wrong");
                }
                return;
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invaid response")
                DispatchQueue.main.async {
                    self.homeDataFetchDelegate?.didFailWithError(error: "Something went wrong");
                }
                return;
            }
            
            if let data = data {
                var decoder = JSONDecoder()
                do {
                    let responseData = try decoder.decode(BaseWrapper.self, from: data)
                    if responseData.success {
                        DispatchQueue.main.async {
                            self.homeDataFetchDelegate?.didFetchHomeData(homeData: responseData.results);
                        }
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        self.homeDataFetchDelegate?.didFailWithError(error: "Something went wrong");
                    }
                    print(error)
                }
            }
            
            
        }
        
        session.resume();
        
    }
    
}
