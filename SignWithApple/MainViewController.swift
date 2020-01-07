//
//  MainViewController.swift
//  SignWithApple
//
//  Created by Ricky Erdiansyah on 27/11/19.
//  Copyright © 2019 Ricky Erdiansyah. All rights reserved.
//

import UIKit
import AuthenticationServices

class MainViewController: UIViewController {

    // MARK: - Variable
    var data: [String] = []
    var user: User?
    var first: String = ""
    var last: String = ""
    var email: String = ""
    let operationIDLogout: ASAuthorization.OpenIDOperation = .operationLogout
    
    /// Outlet
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBAction func signOutBtn(_ sender: Any) {
         //Keychain.deleteUserIdentifierFromKeychain()
       performSegue(withIdentifier: "backToFirstView", sender: nil)
    }
    
    @IBOutlet weak var detailsLbl: UILabel!
    
    @IBOutlet weak var firstNameLbl: UILabel!
    
    @IBOutlet weak var lastnameLbl: UILabel!
    
    @IBOutlet weak var emailUserLbl: UILabel!
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsLbl.text = user?.debugDescription ?? ""
        
        //detailsLbl.text = Keychain.currentUserIdentifier
//        data.append("AAA")
//        data.append("BBB")
//        data.append("CCC")

        print(user?.id)
        
        firstNameLbl.text = first
        
        lastnameLbl.text = last
        
        emailUserLbl.text = email
        print(data.count)
    }
    
    // MARK: - View will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if data.count != 0 {
            tableView.separatorStyle = .singleLine
            count = data.count
            tableView.backgroundView = nil
        }else {
            let noDataLbl: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLbl.text = "No Data Available"
            noDataLbl.textColor = UIColor.black
            noDataLbl.textAlignment = .center
            tableView.backgroundView = noDataLbl
            tableView.separatorStyle = .none
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableViewCell
        cell.leftLbl.text = data[indexPath.row]
        
        return cell
    }
    
    
}
