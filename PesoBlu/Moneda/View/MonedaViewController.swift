//
//  MonedaViewController.swift
//  PesoBlu
//
//  Created by Daniel Francisco Carcacha on 14/06/23.
//

import UIKit

class MonedaViewController: UIViewController {
    var auxValorCalculado: String = ""
    var auxValorCalculado2: String = ""
    var auxPesosDolar: Double = 1.00
    var auxDolarPesos: Double = 1.00
    var manager = MonedaDataManager()
    var monedaPickerView = UIPickerView()
    var updatedText: String = ""
    var monedaSeleccionada: String = ""
    var calculatedValue = ""{
        didSet{
            compraMonedaLabel.text = calculatedValue
        }
    }
    var pesosOtroLabel = ""{
        didSet{
            ventaMonedaLabel.text = pesosOtroLabel
        }
    }
    
    let changeM = ChangeManager()
    @IBOutlet var cantidadTextfield: UITextField!
    @IBOutlet var pesosaSegmentControl: UISegmentedControl!
    
    @IBAction func switchSegmentedControl(_ sender: Any) {
        switch pesosaSegmentControl.selectedSegmentIndex{
        case 0:
            pesosaSegmentControl.tag = 0
            calculatedValue = auxValorCalculado
            pesosOtroLabel = String(format: "%.2f", auxPesosDolar)
            switch monedaSeleccionada{
            case "BRL":
                return aMonedaLabel.text = "En Reales"
            case "CLP":
                return aMonedaLabel.text = "En Pesos CH"
            case "UYU":
                return aMonedaLabel.text = "En Pesos Uy"
            default:
                return aMonedaLabel.text = "Error"
            }
            
        case 1:
            pesosaSegmentControl.tag = 1
            calculatedValue = auxValorCalculado2
            pesosOtroLabel = String(format: "%.2f", auxDolarPesos)
            aMonedaLabel.text = "En Pesos Arg"
            
        default:
            print("error")
        }
    }
    @IBOutlet var monedaTextField: UITextField!
    //label para la moneda elegida
    @IBOutlet var compraMonedaLabel: UILabel!
    //label derecho para U$D
    @IBOutlet var ventaMonedaLabel: UILabel!
    @IBOutlet var aMonedaLabel: UILabel!
    @IBOutlet var aDolarLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monedaTextField.isEnabled = false
        pesosaSegmentControl.isEnabled = false
        self.hideKeyboardWhenTappedAround()
        cantidadTextfield.delegate = self
       
        monedaPickerView.delegate = self
        monedaPickerView.dataSource = self
        initialize()

    }
    

    // Mientras se edita el texto verifico si el textfield esta vacio, si es asi deshabilito el picker y el segmentcontrol
    // si no esta vacio los habilito.
    @IBAction func cantidadTextEditingChanged(_ sender: UITextField) {
        if cantidadTextfield.text?.isEmpty ?? true{
            monedaTextField.isEnabled = false
            pesosaSegmentControl.isEnabled = false
            //cantidadTextfield.text = sender.text
            
        }else {
            monedaTextField.isEnabled = true
            pesosaSegmentControl.isEnabled = true
        }
    }

    // MARK: - MonedaViewController Extension

}
extension MonedaViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    func initialize(){
        
        cantidadTextfield.textAlignment = .center
        cantidadTextfield.placeholder = "Ingrese la cantidad de dinero a convertir"
        monedaTextField.placeholder = "Seleccione una moneda para convertir"
        monedaTextField.inputView = monedaPickerView
        monedaTextField.textAlignment = .center
        cantidadTextfield.keyboardType = .decimalPad
        pesosaSegmentControl.tag = 0
        aMonedaLabel.text = "En Moneda X"
        aDolarLabel.text = "En U$D"
        pesosaSegmentControl.setTitle("$", forSegmentAt: 0)
        pesosaSegmentControl.setTitle("$", forSegmentAt: 1)
        
        //cantidadTextfield.resignFirstResponder()
    }
    
    //MARK: - Dismiss Keyboard Methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Cuando finaliza la edición del textField, deshabilita el pickerView si está vacío
        if textField.text!.isEmpty  {
            monedaTextField.isEnabled = false
            pesosaSegmentControl.isEnabled = false
            compraMonedaLabel.text = "0.00"
            ventaMonedaLabel.text = "0.00"
        }
    }
    
    @objc func hideKeyboardWhenTappedAround() {
        //Agrega un gesto de reconocimiento para detectar cuando se toca la pantalla fuera del teclado
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        // Oculta el teclado al tocar la pantalla fuera del campo de texto
        view.endEditing(true)
    }
    
    //MARK: - Text Field Methods
    //funcion que me sirve para tomar por parametro tipeado en un textfield y actualiza la variable updatetext
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Concatena el texto existente en el campo de texto con la cadena de reemplazo
            updatedText = (cantidadTextfield.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            //let monedaSeleccionada = manager.currencyArray[row]
        
            // Realiza las operaciones necesarias con el nuevo valor de texto
        monedaTextField.text = "Seleccione una moneda para convertir"
        monedaTextField.textColor = .systemRed
        
            // Retorna true para permitir que se realice el cambio en el campo de texto
            return true
        }
    
    //MARK: - Picker View DataSource and Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        manager.numberoItemsMoneda()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch manager.currencyArray[row]{
        case "BRL":
            return "Real Brasileño"
        case "CLP":
            return "Peso Chileno"
        case "UYU":
            return "Peso Uruguayo"
        default:
            return "Error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        monedaSeleccionada = manager.currencyArray[row]
        switch manager.currencyArray[row]{
        case "BRL":
            monedaTextField.textColor = .black
            monedaTextField.text = "Real Brasil"
            //nombramos los segmentcontrol
            pesosaSegmentControl.setTitle("$ -> R$", forSegmentAt: 0)
            pesosaSegmentControl.setTitle("R$ -> $", forSegmentAt: 1)
            //nombramos el label
            //aMonedaLabel.text = "En Reales"
            manager.fetchChange(for: monedaSeleccionada) { moneda in
                DispatchQueue.main.async { [self] in
                    
                    let cantidadDolaresMoneda = Double(moneda.rates.BRL.rate!)
                    
                    manager.calcularValor(for: updatedText, for: cantidadDolaresMoneda!, for: pesosaSegmentControl.tag) { [self] valorCalculado, pesosDolar, valorCalculado2, dolarPesos in
                        auxValorCalculado = valorCalculado
                        auxValorCalculado2 = valorCalculado2
                        auxPesosDolar = pesosDolar
                        auxDolarPesos = dolarPesos
                        
                        if pesosaSegmentControl.tag == 0{
                            aMonedaLabel.text = "En Reales"
                            calculatedValue = auxValorCalculado
                            pesosOtroLabel = String(format: "%.2f", auxPesosDolar)
                        }else {
                            aMonedaLabel.text = "En Pesos Arg"
                            calculatedValue = auxValorCalculado2
                            pesosOtroLabel = String(format: "%.2f", auxDolarPesos)
                        }
                    }
                }
            }
            monedaTextField.resignFirstResponder()
        case "CLP":
            monedaTextField.textColor = .black
            monedaTextField.text = "Peso Chileno"
            pesosaSegmentControl.setTitle("$ -> C$", forSegmentAt: 0)
            pesosaSegmentControl.setTitle("C$ -> $", forSegmentAt: 1)
            manager.fetchChange(for: monedaSeleccionada) { moneda in
                DispatchQueue.main.async { [self] in
                    let cantidadDolaresMoneda = Double(moneda.rates.CLP.rate!)

                    manager.calcularValor(for: updatedText, for: cantidadDolaresMoneda!, for: pesosaSegmentControl.tag) { [self] valorCalculado, pesosDolar, valorCalculado2, dolarPesos in
                        auxValorCalculado = valorCalculado
                        auxValorCalculado2 = valorCalculado2
                        auxPesosDolar = pesosDolar
                        auxDolarPesos = dolarPesos
                        
                        if pesosaSegmentControl.tag == 0{
                            aMonedaLabel.text = "En Pesos CH"
                            calculatedValue = auxValorCalculado
                            pesosOtroLabel = String(format: "%.2f", auxPesosDolar)
                        }else {
                            aMonedaLabel.text = "En Pesos Arg"
                            calculatedValue = auxValorCalculado2
                            pesosOtroLabel = String(format: "%.2f", auxDolarPesos)
                        }
                    }
                }
            }
            monedaTextField.resignFirstResponder()
        case "UYU":
            monedaTextField.textColor = .black
            monedaTextField.text = "Peso Uruguayo"
            pesosaSegmentControl.setTitle("$ -> U$", forSegmentAt: 0)
            pesosaSegmentControl.setTitle("U$ -> $", forSegmentAt: 1)
            manager.fetchChange(for: monedaSeleccionada) { moneda in
                DispatchQueue.main.async { [self] in
                    let cantidadDolaresMoneda = Double(moneda.rates.UYU.rate!)

                    manager.calcularValor(for: updatedText, for: cantidadDolaresMoneda!, for: pesosaSegmentControl.tag) { [self] valorCalculado, pesosDolar, valorCalculado2, dolarPesos in
                        auxValorCalculado = valorCalculado
                        auxValorCalculado2 = valorCalculado2
                        auxPesosDolar = pesosDolar
                        auxDolarPesos = dolarPesos
                        
                        if pesosaSegmentControl.tag == 0{
                            aMonedaLabel.text = "En Pesos Uy"
                            calculatedValue = auxValorCalculado
                            pesosOtroLabel = String(format: "%.2f", auxPesosDolar)
                        }else {
                            aMonedaLabel.text = "En Pesos Arg"
                            calculatedValue = auxValorCalculado2
                            pesosOtroLabel = String(format: "%.2f", auxDolarPesos)
                        }
                    }
                }
            }
            monedaTextField.resignFirstResponder()
        default:
            monedaTextField.text = "Error"
            monedaTextField.resignFirstResponder()
        }
    }
}


