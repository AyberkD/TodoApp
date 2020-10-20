//
//  UpdateTodoViewController.swift
//  TodoApp
//
//  Created by Ayberk Demirkol on 20/10/2020.
//

import UIKit

class UpdateTodoViewController: UIViewController {
    
    var todoIndex: Int!
    private var todoViewModel: TodoViewModel!

    // MARK: - UI Components
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Todo Name"
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Helvetica Neue", size: 14)
        textField.returnKeyType = .next
        
        return textField
    }()
    
    private var detailTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.font = UIFont(name: "Helvetica Neue", size: 14)
        textView.returnKeyType = .done
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callToViewModelForUpdate()
        updateView()
    }
    
    private func setupView(){
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        view.addSubview(detailTextView)
        detailTextView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40).isActive = true
        detailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailTextView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8).isActive = true
        detailTextView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func callToViewModelForUpdate(){
        self.todoViewModel = TodoViewModel()
        self.todoViewModel.bindTodoViewModelToController = {
        }
    }
    
    func updateView(){
        DispatchQueue.main.async {
            let item = self.todoViewModel.data[self.todoIndex]
            print("Item name is : \(item.name)")
            print("Item description is : \(item.detail)")
            self.nameTextField.text = item.name
            self.detailTextView.text = item.detail
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let item = self.todoViewModel.data[todoIndex]
        self.todoViewModel.updateTodo(item, name: nameTextField.text!, detail: detailTextView.text)
        self.navigationController?.popViewController(animated: true)
    }
}
