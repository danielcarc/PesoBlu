//
//  CurrencyViewController.swift
//  PesoBlu
//
//  Created by Daniel Francisco Carcacha on 07/06/23.
//

import UIKit

class ChangeViewController: UIViewController{
    
    @IBOutlet var oficialCompra: UILabel!
    @IBOutlet var oficialVenta: UILabel!
    @IBOutlet var blueCompra: UILabel!
    @IBOutlet var blueVenta: UILabel!
    @IBOutlet var euroCompra: UILabel!
    @IBOutlet var euroVenta: UILabel!
    @IBOutlet var lastUpdateLabel: UILabel!
    
    //instanciamos la clase que contiene las funciones para visualizar la view
    var manager = ChangeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hilo principal para la funcion
        DispatchQueue.main.async { [self] in
            initialize()
        }
    }
}
extension ChangeViewController{
    func initialize(){
        manager.fetchChange { change in
            DispatchQueue.main.async {
                //les asignamos valores a los label
                self.oficialCompra.text = String(format: "%.2f", change.oficial.value_buy)
                self.oficialVenta.text = String(format: "%.2f", change.oficial.value_sell)
                self.blueCompra.text = String(format: "%.2f", change.blue.value_buy)
                self.blueVenta.text = String(format: "%.2f", change.blue.value_sell)
                self.euroCompra.text = String(format: "%.2f", change.blue_euro.value_buy)
                self.euroVenta.text = String(format: "%.2f", change.blue_euro.value_sell)
                self.lastUpdateLabel.text = String(change.actualizacion)
            }
        }
        title = "Cotizaciones"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
