//
//  TodoViewModel.swift
//  TodoApp
//
//  Created by Ayberk Demirkol on 20/10/2020.
//

import Foundation
import UIKit
import CoreData

protocol TodoViewModelDelegate: NSObjectProtocol{
    func didFinishDeletingData()
    func didStartFetchingData()
    func didFinishFetchingData()
}

class TodoViewModel: NSObject{
    
    var todoViewModelDelegate: TodoViewModelDelegate?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private(set) var data: [TodoItem] = []
    
    /// Removes a todo item at selected index and saves core data.
    /// - Parameter index: index of item to be removed
    func deleteTodo(at index: Int){
        DispatchQueue.main.async {
            let item = self.data[index]
            self.data.remove(at: index)
            self.context.delete(item)
            
            do{
                try self.context.save()
            }catch{
                print("Error while deleting item: \(error)")
            }
            self.todoViewModelDelegate?.didFinishDeletingData()
        }
    }
    
    /// Updates a todo item at selected item and saves core data.
    /// - Parameters:
    ///   - index: index of item to be updated
    ///   - name: updated name of item
    ///   - detail: updated detail of item
    func updateTodo(at index: Int, name: String?, detail: String?){
        DispatchQueue.main.async {
            let item = self.data[index]
            item.name = name
            item.detail = detail
            
            do{
                try self.context.save()
            }catch{
                print("Error saving data: \(error)")
            }
        }
    }
    
    /// Sends a fetch request to core data to retrieve todo items.
    func fetchData(){
        todoViewModelDelegate?.didStartFetchingData()
        DispatchQueue.main.async{
            let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()

            do{
                self.data = try self.context.fetch(request)
            }catch{
                print("Error received while fetching data: \(error)")
            }
            self.todoViewModelDelegate?.didFinishFetchingData()
        }
    }
    
    /// Creates a new todo item and saves to core data.
    /// - Parameters:
    ///   - name: name of the new todo item
    ///   - detail: description of the new todo item
    func createTodo(name: String, detail: String){
        DispatchQueue.main.async {
            let newItem = TodoItem(context: self.context)
            newItem.name = name
            newItem.detail = detail
            
            do{
                try self.context.save()
            }catch{
                print("Error saving data: \(error)")
            }
        }
    }
}
