//
//  TodoViewModel.swift
//  TodoApp
//
//  Created by Ayberk Demirkol on 20/10/2020.
//

import Foundation
import UIKit
import CoreData

class TodoViewModel: NSObject{
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private(set) var data : [TodoItem]! {
        didSet {
            self.bindTodoViewModelToController()
        }
    }
    
    override init() {
        super.init()
        loadData()
    }
    
    var bindTodoViewModelToController : (() -> ()) = {}
    
    func deleteTodo(at index: Int){
        let item = data[index]
        data.remove(at: index)
        context.delete(item)
        
        do{
            try context.save()
        }catch{
            print("Error while deleting item: \(error)")
        }
    }
    
    func updateTodo(_ item: TodoItem, name: String, detail: String){
        item.name = name
        item.detail = detail
        
        do{
            try context.save()
        }catch{
            print("Error saving data: \(error)")
        }
    }

    func loadData(){
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        do{
            data = try context.fetch(request)
        }catch{
            print("Error received while fetching data: \(error)")
        }
    }
    
    func createTodo(_ name: String, _ detail: String){
        let newItem = TodoItem(context: self.context)
        newItem.name = name
        newItem.detail = detail
        
        do{
            try context.save()
        }catch{
            print("Error saving data: \(error)")
        }
    }
}
