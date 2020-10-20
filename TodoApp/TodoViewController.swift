//
//  ViewController.swift
//  TodoApp
//
//  Created by Ayberk Demirkol on 20/10/2020.
//

import UIKit

class TodoViewController: UITableViewController {
    
    private var todoViewModel: TodoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUpdate()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
        
    override func viewWillAppear(_ animated: Bool) {
        todoViewModel.loadData()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoViewModel.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
        
        let item = todoViewModel.data[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.detail
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            todoViewModel.deleteTodo(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "todoDetail", sender: indexPath.row)
        
    }

    func callToViewModelForUpdate(){
        todoViewModel = TodoViewModel()
        todoViewModel.bindTodoViewModelToController = {
            
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addButtonTapped", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todoDetail"{
            let vc = segue.destination as! UpdateTodoViewController
            vc.todoIndex = sender as! Int
        }
    }
}

