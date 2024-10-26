//
//  AnimalViewController.swift
//  ANimalInformation

//

import UIKit
import CoreData

class AnimalViewController: UIViewController {
    // vars and methods
    var animalData : Animal!
    // outlets and actions
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
    @IBOutlet weak var trineLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var collectButton: UIButton!
   
   
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        if let testVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestViewController") as? TestViewController {
                testVC.pManagedObject = self.animalData
                self.navigationController?.pushViewController(testVC, animated: true)
            } else {
                print("Debug: Failed to instantiate TestViewController")
            }
    }
    

    @IBAction func toggleCollect(_ sender: UIButton) {
        let newStatus = !animalData.isCollected
            animalData.isCollected = newStatus
            if newStatus {
                // When the animal is collected, create a new Collected entry
                let collectedEntry = Collected(context: context)
                collectedEntry.relationship = animalData  // Linking the animal to the collected entry
               
            } else {
                // When the animal is uncollected, find and delete the corresponding Collected entry
                let fetchRequest: NSFetchRequest<Collected> = Collected.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "relationship == %@", animalData)
                
                do {
                    let results = try context.fetch(fetchRequest)
                    if let entry = results.first {
                        context.delete(entry)
                    }
                } catch {
                    print("Error fetching Collected entries: \(error)")
                }
            }
            updateCollectButtonUI()
            saveContext()
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }


    func updateCollectButtonUI() {
        collectButton.isSelected = animalData.isCollected
    }



    // MARK: - Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pEntity : NSEntityDescription!
    var pManagedObject : Animal!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // fill the label and image view with data
        
        animalNameLabel.text = animalData.name
        animalImageView.image = UIImage(named: animalData.image2!)
        trineLabel.text = animalData.trine
        updateCollectButtonUI()
        // i don't know why when going to this page by clicking the collection cell it appears a title on top which is inconsistent with the precious layout so i added this line 
        self.navigationItem.title = nil
  

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animalImageView.layer.cornerRadius = animalImageView.frame.size.width / 12
        moreInfoButton.layer.cornerRadius = 10
        moreInfoButton.clipsToBounds = true
        

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1"{
            // Get the new view controller using segue.destination.
            let destination = segue.destination as! DetailsViewController
            
            // Pass the selected object to the new view controller.
            destination.animalData = self.animalData
        }
    }
    

}
