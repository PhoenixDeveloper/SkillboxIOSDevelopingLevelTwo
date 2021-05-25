//
//  NewTaskViewController.swift
//  Lesson4
//
//  Created by Михаил Беленко on 19.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol NewTaskViewController: class {
}

// VIPER
final class NewTaskViewControllerImp: UIViewController {
    private var presenter: NewTaskPresenter?
    
    private let keyboardObserver = KeyboardObserver()
    private let disposeBag = DisposeBag()
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Наименование задачи:"
        return label
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private lazy var deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "Срок задачи:"
        return label
    }()
    
    private lazy var deadlineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var deadlineTextField: UITextField = {
        let textField = UITextField()
        textField.text = dateFormatter.string(from: Date())
        textField.inputView = deadlineDatePicker
        textField.inputAccessoryView = getToolbar()
        return textField
    }()
    
    private lazy var deadlineDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание задачи:"
        return label
    }()
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.keyboardObserver.onKeyboardWillShow = { [weak self] frame, animationDuration in
            self?.keyboardWillShow(keyboardFrame: frame, animationDuration: animationDuration)
        }
        
        self.keyboardObserver.onKeyboardWillHide = { [weak self] frame, animationDuration in
            self?.keyboardWillHide(keyboardFrame: frame, animationDuration: animationDuration)
        }
        
        self.keyboardObserver.onKeyboardFrameWillChange = { [weak self] frame, animationDuration in
            self?.keyboardWillShow(keyboardFrame: frame, animationDuration: animationDuration)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = NewTaskPresenterImp(viewController: self, navigationController: navigationController)
        
        addSubviews()
        setupConstraints()
        configureEvents()
    }
    
    private func getToolbar() -> UIToolbar {
        let doneButton = UIBarButtonItem.init(title: "Применить", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        return toolBar
    }
    
    @objc private func datePickerDone() {
        deadlineTextField.resignFirstResponder()
    }
    
    @objc private func dateChanged() {
        deadlineTextField.text = dateFormatter.string(from: deadlineDatePicker.date)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleView)
        titleView.addSubview(titleTextField)
        
        scrollView.addSubview(deadlineLabel)
        scrollView.addSubview(deadlineView)
        deadlineView.addSubview(deadlineTextField)
        
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(descriptionView)
        descriptionView.addSubview(descriptionTextView)
        
        scrollView.addSubview(closeButton)
        scrollView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        deadlineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        deadlineView.snp.makeConstraints { make in
            make.top.equalTo(deadlineLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        deadlineTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(deadlineView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.centerX).offset(-8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.centerX).offset(8)
        }
    }
    
    private func configureEvents() {
        closeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak presenter] in
            presenter?.dismiss()
        }).disposed(by: disposeBag)
        
        saveButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            self?.presenter?.save(name: self?.titleTextField.text ?? "", deadline: self?.dateFormatter.date(from: self?.deadlineTextField.text ?? "") ?? Date(), description: self?.descriptionTextView.text ?? "")
        }).disposed(by: disposeBag)
        
        hideKeyboardWhenTappedAround()
    }
}

extension NewTaskViewControllerImp: NewTaskViewController {
}

extension NewTaskViewControllerImp {
    func keyboardWillShow(keyboardFrame: CGRect, animationDuration: Double) {
        let keyboardHeight = keyboardFrame.height - view.safeAreaInsets.bottom
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 16, right: 0)
        let scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = scrollIndicatorInsets
    }
    
    func keyboardWillHide(keyboardFrame: CGRect, animationDuration: Double) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
