//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Tosin Peters on 2016-12-17.
//  Copyright © 2016 Tosin Peters. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var selectStore: UILabel!
    @IBOutlet weak var thumbImg: UIImageView!
    var stores = [Store]()

    var itemToEdit: Item?
    
    var imagePicker: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        generateData()
        getStores()
        
        if itemToEdit != nil{
            
            loadItemData()
        }
        
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumbImg.image
        
        
        if  itemToEdit == nil {
            item = Item(context: context)
        }else{
            item = itemToEdit
        }
        
        item.toImage = picture
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
       

        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
            //loadItemData()
            
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        //update when selected
        
    }
    
    
    
    func getStores()
    {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch{
            let error = error as NSError
            print("\(error)")
        }
    }
    
    
    func generateData()
    {
        let store0 = Store(context: context)
        store0.name = "Best Buy"
        let store1 = Store(context: context)
        store1.name = "staples"
        let store2 = Store(context: context)
        store2.name = "Aliexpress"
        let store3 = Store(context: context)
        store3.name = "Amazon"
        let store4 = Store(context: context)
        store4.name = "Ebay"
        
        ad.saveContext()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func loadItemData()
    {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            
            thumbImg.image = item.toImage?.image as? UIImage
            if let store = item.toStore{
                var index = 0
                repeat{
                    let s = stores[index]
                    if s.name == store.name{
                        storePicker.selectedRow(inComponent: index)
                        break
                    }
                    index += 1
                }while(index < stores.count)
            }
        }
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        
        
        present(imagePicker, animated:true, completion: nil)
        
    }
   
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            thumbImg.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

}
