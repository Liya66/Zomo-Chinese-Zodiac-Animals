//
//  FindTableViewController.swift
//  ANimalInformation
//
//  Created by Liya Wang on 04/03/2024.
//

import UIKit
import CoreData


class FindTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var AnimalTable: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make data
//        animalsData = Animals(fromXMLfile: "animals.xml")
        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        print(frc as Any)
        // fetch and check fetched results
        do{
            try frc.performFetch()
            if frc.sections![0].numberOfObjects == 0{
                xml2CD()
            }
            try frc.performFetch()
        }catch{
            print("CORE DATA CANNOT FETCH")
        }
      
        
        // Set table view data source and delegate
        AnimalTable.dataSource = self
        AnimalTable.delegate = self
        
        AnimalTable.register(CustomAnimalCell.self, forCellReuseIdentifier: "cell")
        
        //remove the line between cells
        
        AnimalTable.separatorStyle = .none
        
        
        // Configure the datePicker to remove the time
        datePicker.datePickerMode = .date
        printDatabaseLocation()
        

    }
    
    func printDatabaseLocation() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Database Location: \(urls[urls.count-1] as URL)")
    }
    
    //MARK: - Core Data
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pEntity : NSEntityDescription!
    var pManagedObject : Animal!
    var frc : NSFetchedResultsController<NSFetchRequestResult>!
    
    func makeRequest()->NSFetchRequest<NSFetchRequestResult>{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Animal")
        
        let sorter = NSSortDescriptor(key: "orderIndex", ascending: true)
            request.sortDescriptors = [sorter]
        
        // give predicates for filtering
        return request
        
    }
    
 
    func xml2CD() {
        let parser = XMLAnimalParser(xmlName: "animals.xml")
        parser.parsing()

        // get the parsed data
        let animalData = parser.animalsData

        // traverse the parse data to make new managed objects
        animalData.enumerated().forEach { index, animal in
            pEntity = NSEntityDescription.entity(forEntityName: "Animal", in: context)
            pManagedObject = Animal(entity: pEntity, insertInto: context)
            pManagedObject.name = animal.name
            pManagedObject.element = animal.element
            pManagedObject.character = animal.character
            pManagedObject.image = animal.image
            pManagedObject.url = animal.url
            pManagedObject.trine = animal.trine
            pManagedObject.image2 = animal.image2
            pManagedObject.yy = animal.yy
            pManagedObject.orderIndex = Int32(index)  // now 'index' is properly defined

            do {
                try context.save()
            } catch {
                print("CORE DATA CANNOT SAVE: \(error.localizedDescription)")
            }
        }
    }


    @IBAction func findAnimalButton(_ sender: Any) {
    }
    // DataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return frc.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections![section].numberOfObjects
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      AnimalTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomAnimalCell
        
        let animalData = frc.object(at: indexPath) as? Animal
        cell.customTextLabel.text = animalData!.name
        cell.customDetailTextLabel.text = animalData!.character
        cell.customImageView.image = UIImage(named: animalData!.image2!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Get the Animal object for the selected row
        if let animal = frc.object(at: indexPath) as? Animal {
            // Instantiate the AnimalViewController from the storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let animalVC = storyboard.instantiateViewController(withIdentifier: "AnimalViewController") as? AnimalViewController {
                animalVC.animalData = animal // Pass the selected animal data to the view controller
                // Check if there's a navigation controller and push the AnimalViewController onto the stack
                if let navigator = navigationController {
                    navigator.pushViewController(animalVC, animated: true)
                } else {
                    // If there's no navigation controller, present the view controller 
                    present(animalVC, animated: true, completion: nil)
                }
            }
        }
    }
    
  
   
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var zodiacAnimalLabel: UILabel!
    
    
    @IBAction func findAnimal(_ sender: Any) {
        let chineseCalendar = Calendar(identifier: .chinese)
        let birthDate = datePicker.date
        
        // Directly use the birthDate to get the year component in Chinese calendar
        let lunarYearComponent = chineseCalendar.component(.year, from: birthDate)
        let animal = zodiacAnimal(forYear: lunarYearComponent)
        
        // Display the result
        zodiacAnimalLabel.text = animal}
    
    
    func zodiacAnimal(forYear year: Int) -> String {
        let animals = ["Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"]
        let index = (year-1) % 12 // The cycle starts with Rat for the year 1
        return animals[index]
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    // Override to support conditional editing of the table view.
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete pManagedObject from indexPath
            pManagedObject = frc.object(at: indexPath) as? Animal
            context.delete(pManagedObject)
            do {
                       try context.save()
                   } catch {
                       let nserror = error as NSError
                       fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                   }
               }
        
    }
    
 
    }


