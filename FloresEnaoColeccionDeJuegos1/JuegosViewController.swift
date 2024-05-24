//
//  JuegosViewController.swift
//  FloresEnaoColeccionDeJuegos1
//
//  Created by Flores Enao Eduardo Andre on 6/05/24.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return categorias[row]
        }
    

    @IBOutlet weak var actualizarbtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var eliminarBotton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView! // Enlazar con el Picker View en el storyboard

    
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    var categorias = ["Aventura", "Acción", "Deportes", "Estrategia", "Puzzle"] // Ejemplo de categorías

    
    override func viewDidLoad() {
            super.viewDidLoad()
            imagePicker.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
            
            if juego != nil {
                imageView.image = UIImage(data: (juego!.imagen!) as Data)
                tituloTextField.text = juego!.titulo
                if let categoria = juego!.categoria, let index = categorias.firstIndex(of: categoria) {
                    pickerView.selectRow(index, inComponent: 0, animated: false)
                }
                actualizarbtn.setTitle("Actualizar", for: .normal)
            } else {
                eliminarBotton.isHidden = true
            }
        }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
    }

    @IBAction func agregarTapped(_ sender: Any) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            if juego != nil {
                juego!.titulo = tituloTextField.text
                juego!.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
                juego!.categoria = categorias[pickerView.selectedRow(inComponent: 0)]
            } else {
                let juego = Juego(context: context)
                juego.titulo = tituloTextField.text
                juego.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
                juego.categoria = categorias[pickerView.selectedRow(inComponent: 0)]
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        imageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }

    
}

////
////  JuegosViewController.swift
////  FloresEnaoColeccionDeJuegos1
////
////  Created by Flores Enao Eduardo Andre on 6/05/24.
////
//
//import UIKit
//
//class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @IBOutlet weak var actualizarbtn: UIButton!
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var tituloTextField: UITextField!
//    @IBOutlet weak var eliminarBotton: UIButton!
//
//
//    var imagePicker = UIImagePickerController()
//    var juego:Juego? = nil
//
//    var categorias = ["Aventura", "Acción", "Deportes", "Estrategia", "Puzzle"] // Ejemplo de categorías
//
//    var selectedOption: String?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imagePicker.delegate = self
//        imagePicker.delegate = self
//
//        // Configurar datos del picker
//        pickerView.reloadAllComponents()
//        if juego != nil {
//            imageView.image = UIImage(data: (juego!.imagen!) as Data)
//            tituloTextField.text = juego!.titulo
//            actualizarbtn.setTitle("Actualizar", for: .normal)
////            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
//        }else{
//            eliminarBotton.isHidden = true
//        }
//
//    }
//
//    @IBAction func fotosTapped(_ sender: Any) {
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    @IBAction func camaraTapped(_ sender: Any) {
//    }
//
//    @IBAction func agregarTapped(_ sender: Any) {
//        if juego != nil {
//            juego!.titulo! = tituloTextField.text!
//            juego!.imagen = imageView.image?.jpegData( compressionQuality: 0.50)
//
//        }else{
//
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let juego = Juego(context: context)
//        juego.titulo = tituloTextField.text
//        juego.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
//        }
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//        navigationController?.popViewController(animated: true)
//
//    }
//
//    @IBAction func eliminarTapped(_ sender: Any) {
//
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        context.delete(juego!)
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//        navigationController?.popViewController(animated: true)
//    }
//
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let imagenSeleccionada = info[.originalImage] as? UIImage
//        imageView.image = imagenSeleccionada
//        imagePicker.dismiss(animated: true, completion: nil)
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedOption = pickerData[row] // pickerData es el arreglo que contiene los datos del picker
//    }
//
//
//}
