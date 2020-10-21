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
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue", size: 12)
        label.textColor = .gray
        label.text = "Name"
        label.textAlignment = .left
        
        return label
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Todo Name"
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Helvetica Neue", size: 16)
        
        return textField
    }()
    
    private var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue", size: 12)
        label.textColor = .gray
        label.text = "Detail"
        
        return label
    }()
    
    private var detailTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.font = UIFont(name: "Helvetica Neue", size: 16)
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView(){
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40).isActive = true
        detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8).isActive = true
        detailLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        view.addSubview(detailTextView)
        detailTextView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 5).isActive = true
        detailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailTextView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8).isActive = true
        detailTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
        hideKeyboardWhenTappedAround()
    }
    
    func bindToViewModel(){
        self.todoViewModel = TodoViewModel()
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        self.todoViewModel.createTodo(name: nameTextField.text!, detail: detailTextView.text)
        self.navigationController?.popViewController(animated: true)
    }
    
}
