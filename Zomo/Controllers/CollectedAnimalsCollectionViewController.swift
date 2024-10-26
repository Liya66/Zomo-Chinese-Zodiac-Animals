import UIKit
import CoreData

class CollectedAnimalsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var collectedAnimals = [Animal]() // Array to hold collected animals
    var context: NSManagedObjectContext!  // CoreData context
    static let reuseIdentifier = "CollectedAnimalCell" // Cell reuse identifier

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        loadCollectedAnimals()

        // Layout configuration for grid
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
               layout.minimumInteritemSpacing = 2
               layout.minimumLineSpacing = 2
           }
           collectionView.reloadData()
    }

    // Configure size for each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
           let padding: CGFloat = 5  //  padding on each side
           let totalSpacing: CGFloat = 2 //  spacing between cells

           // Correctly calculating the total horizontal padding
        let totalHorizontalPadding = padding + totalSpacing * (numberOfColumns - 1)
           let width = (collectionView.bounds.width - totalHorizontalPadding) / numberOfColumns

           return CGSize(width: width, height: width)
    }


    func loadCollectedAnimals() {
        let fetchRequest: NSFetchRequest<Collected> = Collected.fetchRequest()
    

        do {
            let results = try context.fetch(fetchRequest)
            collectedAnimals = results.compactMap { $0.relationship } // Using compactMap to safely unwrap and ignore nil values
            collectionView.reloadData()
        } catch let error as NSError {
            print("Could not fetch collected animals: \(error), \(error.userInfo)")
        }
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectedAnimals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectedAnimalsCollectionViewController.reuseIdentifier, for: indexPath)
        cell.contentView.subviews.forEach({ $0.removeFromSuperview() })

        let label = UILabel(frame: CGRect(x: 17, y: 5, width: cell.bounds.width - 10, height: 20))
        label.text = collectedAnimals[indexPath.row].name
        cell.contentView.addSubview(label)

        let imageView = UIImageView(frame: CGRect(x: 5, y: 30, width: cell.bounds.width - 10, height: cell.bounds.height - 35))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: collectedAnimals[indexPath.row].image2 ?? "")
     
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        

        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCollectedAnimals()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAnimal = collectedAnimals[indexPath.row]
        showAnimalDetail(for: selectedAnimal)
    }

    func showAnimalDetail(for animal: Animal) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let animalVC = storyboard.instantiateViewController(withIdentifier: "AnimalViewController") as? AnimalViewController {
            animalVC.animalData = animal
            self.navigationController?.pushViewController(animalVC, animated: true)
        }
    }
    
}
