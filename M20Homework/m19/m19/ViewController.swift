//
//  ViewController.swift
//  m19
//
//  Created by Ka4aH on 27.02.2023.
//

import UIKit
import CoreData

enum Key {
    static let sortingAscending = "ascending"
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }
    
    //UserDefaults
    let defaults = UserDefaults.standard
    private var sortAscTrue: Bool? = true
    private var sortAscFalse: Bool? = false
    
    //Инициализируем CoreData
    private let persistentContainer = NSPersistentContainer(name: "ArtistsList")
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Artists> = {
        let fetchRequest = Artists.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "lastname", ascending: defaults.bool(forKey: Key.sortingAscending))
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.bool(forKey: Key.sortingAscending)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let button = UIBarButtonItem(title: "", image: UIImage(systemName: "list.bullet.indent"), menu: sortingArtist())
        button.tintColor = .systemOrange
        self.navigationItem.leftBarButtonItem = button

        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("\(error), \(error.localizedDescription)")
            } else {
                do {
                    try self.fetchedResultsController.performFetch()
                }
                catch {
                    print(error)
                }
            }
        }
        tableView?.reloadData()
    }

    @IBAction func addNewArtist(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditArtistViewController") as? AddEditArtistViewController {
            vc.artists = Artists.init(entity: NSEntityDescription.entity(forEntityName: "Artists", in: persistentContainer.viewContext)!, insertInto: persistentContainer.viewContext)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func sortingArtist() -> UIMenu {
        let menu = UIMenu(title: "Сортировать по фамилии от:", children: [
            UIAction(title: "А-Я (A-Z)") { [self] action in
                do {
                    _ = Artists.fetchRequest()
                    let sortDescriptor1 = NSSortDescriptor(key: "lastname", ascending: true)
                    fetchedResultsController.fetchRequest.sortDescriptors = [sortDescriptor1]
                    defaults.set(sortAscTrue, forKey: Key.sortingAscending)
                    try self.fetchedResultsController.performFetch()
                    print("Sorting A-Z")
                }
                catch {
                    print(error)
                }
                self.tableView.reloadData()
            },

            UIAction(title: "Я-А (Z-A)") { [self] action in
                do {
                    _ = Artists.fetchRequest()
                    let sortDescriptor2 = NSSortDescriptor(key: "lastname", ascending: false)
                    fetchedResultsController.fetchRequest.sortDescriptors = [sortDescriptor2]
                    defaults.set(sortAscFalse, forKey: Key.sortingAscending)
                    try self.fetchedResultsController.performFetch()
                    print("Sorting Z-A")
                }
                catch {
                    print(error)
                }
                self.tableView.reloadData()
            }
        ])
        return menu
    }
}

//MARK: -- UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artist = fetchedResultsController.object(at: indexPath)
        let cell = UITableViewCell()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemOrange
        cell.selectedBackgroundView = backgroundView
        
        cell.textLabel?.text = (artist.lastname ?? "") + " " + (artist.name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let artist = fetchedResultsController.object(at: indexPath)
            persistentContainer.viewContext.delete(artist)
            try? persistentContainer.viewContext.save()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditArtistViewController") as? AddEditArtistViewController {
            vc.artists = fetchedResultsController.object(at: indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: -- NSFetchedResultsControllerDelegate
extension ViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        print("Start")
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
                print("Add")
            }
        case .update:
            if let indexPath = indexPath {
                let artist = fetchedResultsController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = (artist.lastname ?? "") + " " + (artist.name ?? "")
                print("Update")
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                print("Delete")
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                print("Move")
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                print("Move")
            }
        default:
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        print("Finish")
    }
}
