//
//  CurrencyDataManager.swift
//  PesoBlu
//
//  Created by Daniel Francisco Carcacha on 07/06/23.
//

import Foundation

class MonedaDataManager{
    private var monedas: [String] = []
    
    var currencyArray = ["BRL","CLP","UYU"]

    var changeM = ChangeManager()
    //var dolarBlueCompra: Int = 0
    //var dolarBlueVenta: Int = 0
    
    //necesito hacer un modelo con la cantidad de parametros que quiero del bluelytics
    //y despues convertir a real, que para eso necesito hacer el request
    let currencyUrl = "https://api.getgeoapi.com/v2/currency/convert?api_key="
    let apiKey = "99f81f10b5b6b92679b9051bdce40b7647f150e0"
//https://api.getgeoapi.com/v2/currency/convert?api_key=99f81f10b5b6b92679b9051bdce40b7647f150e0&from=USD&to=BRL&format=json
    
    func fetchChange(for currency: String, completion: @escaping (MonedaModel) -> Void){
        guard let url = URL(string: "\(currencyUrl)\(apiKey)&from=USD&to=BRL,UYU,CLP&format=json")
                
        else{return}
        let dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error{
                print("\(error.localizedDescription)")
            }
            guard let jsonData = data else {return}
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(MonedaModel.self, from: jsonData)
                //print(decodedData.rates.BRL.rate)
                completion(decodedData)
            }catch{
                debugPrint("\(error)")
            }
        }
        dataTask.resume()
    }

    func numberoItemsMoneda() -> Int {
        currencyArray.count
    }
    
    func calcularValor(for cantidadText: String, for cantidadDolaresMoneda: Double, for segmentedControl: Int, completion: @escaping (String, Double, String, Double) -> Void){
        //let cantidadText = self.cantidadTextfield.text
        var valorCalculado: String = "0"
        var valorCalculado2: String = "0"
        let doubleCantidad = Double(cantidadText)
        self.changeM.fetchChange { cambio in
            let blueVenta = Double(cambio.blue.value_sell)
            
            DispatchQueue.main.async {
                
                let pesosDolar = (doubleCantidad ?? 1.00) / blueVenta
                let pesosAOtraMoneda = pesosDolar * cantidadDolaresMoneda
                valorCalculado = String(format: "%.2f", pesosAOtraMoneda)
               
                let dolarMoneda = blueVenta / cantidadDolaresMoneda
                let otraMonedaPeso = dolarMoneda * (doubleCantidad ?? 1.00)
                valorCalculado2 = String(format: "%.2f", otraMonedaPeso)
                let dolarPesos = (doubleCantidad ?? 1.00) / cantidadDolaresMoneda
                completion(valorCalculado, pesosDolar, valorCalculado2, dolarPesos)
                
            }
            
        }
        
    }
}



