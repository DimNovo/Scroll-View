//
//  ViewController.swift
//  Scroll View
//
//  Created by Dmitry Novosyolov on 16/02/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }

    // MARK: - ... Keyboard hide by Keyboard
    @IBAction func finishedEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    // MARK: - ... Keyboard hide by TapGestureRecognizer
    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - ... Keyboard
extension ViewController {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWasShow(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWasShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        
        let height = keyboardFrame.cgRectValue.size.height
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden() {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
