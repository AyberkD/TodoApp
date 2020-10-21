//
//  ViewController.swift
//  TodoApp
//
//  Created by Ayberk Demirkol on 20/10/2020.
//

import UIKit

class TodoViewController: UITableViewController {
    
    private var todoViewModel: TodoViewModel!
    
    lazy var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todoViewModel.fetchData()
    }
    
    func setupView(){
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func bindToViewModel(){
        todoViewModel = TodoViewModel()
        todoViewModel.todoViewModelDelegate = self
    }
    
    // MARK: - Tableview delegate & data source

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
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "todoDetail", sender: indexPath.row)
    }
    
    //MARK: - Button functions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addButtonTapped", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todoDetail"{
            let vc = segue.destination as! UpdateTodoViewController
            vc.todoIndex = sender as? Int
        }
    }
}

    //MARK: - Todo view model delegate

extension TodoViewController: TodoViewModelDelegate{
    
    func didFinishDeletingData() {
        self.tableView.reloadData()
    }
    
    func didFinishFetchingData() {
        activityIndicator.stopAnimating()
        self.tableView.reloadData()
    }
    
    func didStartFetchingData() {
        activityIndicator.startAnimating()
    }
}

