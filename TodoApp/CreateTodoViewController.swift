//
//  CreateTodoViewController.swift
//  TodoApp
//
//  Created by Ayberk Demirkol on 20/10/2020.
//

import UIKit

class CreateTodoViewController: UIViewController {
    
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
        callToViewModelForUpdate()
        setupView()
        // Do any additional setup after loading the view.
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
        self.todoViewModel.bindTodoViewModelToController = {}
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        self.todoViewModel.createTodo(nameTextField.text!, detailTextView.text)
        self.navigationController?.popViewController(animated: true)
    }
    
}
