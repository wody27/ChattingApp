//
//  ChatViewController.swift
//  ChattingApp
//
//  Created by 이재용 on 2020/10/11.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey!"),
        Message(sender: "a@b.com", body: "Hello!"),
        Message(sender: "1@2.com", body: "What's up?")
    ]
    
    //MARK: - 생명주기

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "ChattingApp"
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationItem.hidesBackButton = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextField.addInset()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
    }
    
}

extension UITextField {
    
    func addInset(by inset: CGFloat = 8.0) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        
        return messageCell
    }
}
