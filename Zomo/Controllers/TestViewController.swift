//
//  TestViewController.swift
//  Zomo
//
//  Created by Liya Wang on 2024/4/20.
//

import UIKit
import CoreData

class TestViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var animalData : Animal!
    
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
      
           // Setting up the CoreData context
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           context = appDelegate.persistentContainer.viewContext
           
           // Example of using the context to fetch data right after view loads
           fetchAnimalData()
       }
    
    private func fetchAnimalData() {
            let fetchRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
            // You might want to specify criteria or sorting here
            do {
                let results = try context.fetch(fetchRequest)
                // Process your fetched data here
                print("Fetched \(results.count) animals.")
            } catch {
                print("Failed to fetch animals: \(error)")
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async { // Ensure UI updates are on the main thread
            if let animal = self.pManagedObject {
                self.nameTF.text = animal.name
                self.characterTF.text = animal.character
                self.elementTF.text = animal.element
                self.yyTF.text = animal.yy
                self.trineTF.text = animal.trine
                self.urlTF.text = animal.url
                self.bigImageTF.text = animal.image2
                self.smallImageTF.text = animal.image
                self.updateUIWithAnimalData()
            }
        }
    }
    func updateUIWithAnimalData() {
        if let animal = self.pManagedObject {
            DispatchQueue.main.async {
                print("Updating UI with data: \(String(describing: animal.name))")
                self.nameTF.text = animal.name
                self.nameTF.text = animal.name
                self.characterTF.text = animal.character
                self.elementTF.text = animal.element
                self.yyTF.text = animal.yy
                self.trineTF.text = animal.trine
                self.urlTF.text = animal.url
                self.bigImageTF.text = animal.image2
                self.smallImageTF.text = animal.image
            }
        }else {
            print("No animal data to display.")
        }
        
    }

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var characterTF: UITextField!
    
    @IBOutlet weak var elementTF: UITextField!
    
    @IBOutlet weak var yyTF: UITextField!
    
    @IBOutlet weak var trineTF: UITextField!
    
    @IBOutlet weak var urlTF: UITextField!
    
    @IBOutlet weak var bigImageTF: UITextField!
    
    @IBOutlet weak var smallImageTF: UITextField!
    @IBOutlet weak var pickedImageView: UIImageView!
    
    
    @IBOutlet weak var pickedSmallImageView: UIImageView!
    
    var pickingForSmallImage = false
    
    @IBAction func pickSecondImageAction(_ sender: Any) {
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        picker.delegate = self
        pickingForSmallImage = true
         
        // start picking
        present(picker, animated: true)
    }
    
    @IBAction func pickImageAction(_ sender: Any) {// setup the picker
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        picker.delegate = self
        pickingForSmallImage = false
        // start picking
        present(picker, animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if pManagedObject != nil{
            updateAnimal()
        }else{
            insertAnimal()
        }
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    func updateAnimal(){
        // colect the fields from the outlets
        pManagedObject.name = nameTF.text
        pManagedObject.character = characterTF.text
        pManagedObject.element = elementTF.text
        pManagedObject.yy = yyTF.text
        pManagedObject.trine = trineTF.text
        pManagedObject.url = urlTF.text
        pManagedObject.image2 = bigImageTF.text
        pManagedObject.image = smallImageTF.text
        // save it
        do{
            try context.save()
        }catch{
            print("CORE DATA CANNOT SAVE")
        }
    }
    func insertAnimal(){
        // make a new pManagedObject
        pEntity = NSEntityDescription.entity(forEntityName: "Animal", in: context)
        pManagedObject = Animal(entity: pEntity, insertInto: context)
        
        // colect the fields from the outlets
        pManagedObject.name = nameTF.text
        pManagedObject.character = characterTF.text
        pManagedObject.element = elementTF.text
        pManagedObject.yy = yyTF.text
        pManagedObject.trine = trineTF.text
        pManagedObject.url = urlTF.text
        pManagedObject.image2 = bigImageTF.text
        pManagedObject.image = smallImageTF.text
        // save it
        do{
            try context.save()
        }catch{
            print("CORE DATA CANNOT SAVE")
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    // MARK: - Core Data
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pEntity : NSEntityDescription!
    var pManagedObject : Animal!
    
    
    //MARK: - Image methods
    func getImage(name:String)->UIImage{
        // get the image from Documents and return it
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent(name)
        
        return UIImage(contentsOfFile: filePath)!
        
    }
    
    func getImageToView(name: String) {
        DispatchQueue.main.async {
            let filename = self.getDocumentsDirectory().appendingPathComponent(name)  // Ensure this matches how you save/reference elsewhere
            if let image = UIImage(contentsOfFile: filename.path) {
                self.pickedImageView.image = image
            } else {
                print("Failed to load image from: \(filename.path)")
            }
            
        }
    }

    
    func saveImage(name: String) {
        let image = pickedImageView.image
        let imageData = image?.pngData()
        let filePath = getDocumentsDirectory().appendingPathComponent(name)

        do {
            try imageData?.write(to: filePath)
            print("Image saved successfully at \(filePath)")
        } catch {
            print("Failed to save image: \(error)")
        }
    }

    
    // picker methods
    let picker = UIImagePickerController()
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageName = UUID().uuidString + ".png"
            let filename = getDocumentsDirectory().appendingPathComponent(imageName)

            if let imageData = image.pngData() {
                do {
                    try imageData.write(to: filename)
                    
                    if pickingForSmallImage {
                        smallImageTF.text = filename.path
                        pickedSmallImageView.image = image
                    } else {
                        bigImageTF.text = filename.path
                        pickedImageView.image = image
                    }
                } catch {
                    print("Error saving image: \(error)")
                }
            }
        }

        dismiss(animated: true, completion: nil)
    }



    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
