//
//  ItemDetailsVC.swift
//  UdemyCoreDataV1.3
//
//  Created by Miloš Čampar on 3/15/17.
//  Copyright © 2017 Miloš Čampar. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var price: CustomTextField!
    @IBOutlet weak var details: CustomTextField!
    @IBOutlet weak var imgPicker: UIButton!
    @IBOutlet weak var dataPicker: UIPickerView!
    @IBOutlet weak var thumgImg: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        dataPicker.dataSource = self
        dataPicker.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        getStore()
        
        getData()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStore() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.dataPicker.reloadAllComponents()
            
        } catch {
            let error = error as NSError
                print("\(error)")
        }
    }
    
    func getData() {
        let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Amazon"
        let store3 = Store(context: context)
        store3.name = "eBay"
        let store4 = Store(context: context)
        store4.name = "Reseller"
        let store5 = Store(context: context)
        store5.name = "Tesla Dealership"
        
        ad.saveContext()
    }

    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            price.text = "\(item.price)"
            details.text = item.details
            
            thumgImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        
                        dataPicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
        }
        
    }
    
    @IBAction func pressedSaveBtn(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumgImg.image
        
        
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
            
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            
            item.title = title
        }
        
        if let price = price.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let details = details.text {
            
            item.details = details
        }
        
        item.toStore = stores[dataPicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumgImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}







