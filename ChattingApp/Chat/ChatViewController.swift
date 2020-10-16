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
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
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
        
        loadMessages()
    }
    
    private func loadMessages() {
        
        
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        snapshotDocuments.forEach { (doc) in
                            let data = doc.data()
                            if let sender = data["sender"] as? String, let body = data["body"] as? String {
                                self.messages.append(Message(sender: sender, body: body))
                                
                                
                                DispatchQueue.main.async {
                                    self.messageTableView.reloadData()
                                    self.messageTableView.scrollToRow(at: IndexPath(row: self.messages.count-1, section: 0), at: .top, animated: false)
                                }
                                
                            }
                        }
                    }
                }
            }
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
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody,
                "date": Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print("Success save data ")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
        
    }
    
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let messageCell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        
        
        if message.sender == Auth.auth().currentUser?.email {
            messageCell.leftImageView.isHidden = true
            messageCell.rightImageView.isHidden = false
            messageCell.messageView.backgroundColor = UIColor.lightGray
            messageCell.label.textColor = UIColor.black
        } else {
            messageCell.leftImageView.isHidden = false
            messageCell.rightImageView.isHidden = true
            messageCell.messageView.backgroundColor = UIColor.black
            messageCell.label.textColor = UIColor.white
        }
        
        messageCell.label.text = message.body
        
        return messageCell
    }
}
