//
//  ViewController.swift
//  FloresEnaoColeccionDeJuegos1
//
//  Created by Flores Enao Eduardo Andre on 6/05/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            let juego = juegos[indexPath.row]
            
            cell.textLabel?.text = juego.titulo
            cell.detailTextLabel?.text = juego.categoria // Mostrar la categoría
            cell.imageView?.image = UIImage(data: (juego.imagen!))
            return cell
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "juegoSegue", sender: juego)
    }
    

    @IBOutlet weak var tableView: UITableView!
    var juegos : [Juego] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Habilitar la edición del TableView
            tableView.isEditing = true
            
            // Permitir la selección durante la edición
            tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared .delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        }catch{
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteCV = segue.destination as! JuegosViewController
        siguienteCV.juego = sender as? Juego
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = juegos[indexPath.row]
            context.delete(juego)
            juegos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try context.save()
            } catch {
                print("Error al eliminar el juego: \(error)")
            }
        }
    }

    // Agrega estas funciones para habilitar el reordenamiento de elementos
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedJuego = juegos.remove(at: sourceIndexPath.row)
        juegos.insert(movedJuego, at: destinationIndexPath.row)
        tableView.reloadData() // Actualiza la tabla para reflejar el nuevo orden
        // También puedes actualizar el contexto CoreData aquí si es necesario
    }

}


////
////  ViewController.swift
////  FloresEnaoColeccionDeJuegos1
////
////  Created by Flores Enao Eduardo Andre on 6/05/24.
////
//
//import UIKit
//
//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        let juego = juegos[indexPath.row]
//
//        cell.textLabel?.text = juego.titulo
//        cell.imageView?.image = UIImage(data: (juego.imagen!))
//        return cell
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return juegos.count
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let juego = juegos[indexPath.row]
//        performSegue(withIdentifier: "juegoSegue", sender: juego)
//    }
//
//
//    @IBOutlet weak var tableView: UITableView!
//    var juegos : [Juego] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.isEditing = true
//        tableView.allowsSelectionDuringEditing = true
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        let context = (UIApplication.shared .delegate as! AppDelegate).persistentContainer.viewContext
//        do {
//            try juegos = context.fetch(Juego.fetchRequest())
//            tableView.reloadData()
//        }catch{
//
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "juegoSegue" {
//            if let siguienteCV = segue.destination as? JuegosViewController {
//                siguienteCV.juego = sender as? Juego
//
//                // Obtener la opción seleccionada del UIPickerView
//                if let selectedRow = pickerView.selectedRow(inComponent: 0) {
//                    siguienteCV.selectedOption = pickerData[selectedRow]
//                }
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            let juego = juegos[indexPath.row]
//            context.delete(juego)
//            juegos.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            do {
//                try context.save()
//            } catch {
//                print("Error al eliminar el juego: \(error)")
//            }
//        }
//    }
//
//    // Agrega estas funciones para habilitar el reordenamiento de elementos
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedJuego = juegos.remove(at: sourceIndexPath.row)
//        juegos.insert(movedJuego, at: destinationIndexPath.row)
//        tableView.reloadData() // Actualiza la tabla para reflejar el nuevo orden
//        // También puedes actualizar el contexto CoreData aquí si es necesario
//    }
//
//}
//
