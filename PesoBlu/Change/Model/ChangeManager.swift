//
//  ChangeManager.swift
//  PesoBlu
//
//  Created by Daniel Francisco Carcacha on 07/06/23.
//

import Foundation

//o clase
struct ChangeManager{
    
    

    func fetchChange(completion: @escaping (ChangeModel) -> Void){
        guard let url = URL(string: "https://api.bluelytics.com.ar/v2/latest")
        else{return}
        let dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error{
                print("\(error.localizedDescription)")
            }
            guard let jsonData = data else {return}
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(ChangeModel.self, from: jsonData)
                //print(decodedData.last_update)
                completion(decodedData)
            }catch{
                print("error decoding Data")
            }
        }
        dataTask.resume()
    }
}


