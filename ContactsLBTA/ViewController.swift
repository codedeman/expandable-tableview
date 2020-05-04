//
//  ViewController.swift
//  ContactsLBTA
//
//  Created by Brian Voong on 11/13/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId123123"
    
    var twoDimensionalArray = [
      ExpandableNames(isExpanded: false,title: "Current Acount", names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"]),
        ExpandableNames(isExpanded: false,title: "Saving Acount", names: ["Carl", "Chris", "Christina", "Cameron"]),
        ExpandableNames(isExpanded: true,title: "Saving Acount", names: ["David", "Dan"]),
        ExpandableNames(isExpanded: true,title: "Saving Acount", names: ["Patrick", "Patty"]),
    ]
    
    var showIndexPaths = false
    
    @objc func handleShowIndexPath() {
        
        print("Attemping reload animation of indexPaths...")
        
        // build all the indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()
        
        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].names.indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        
//        for index in twoDimensionalArray[0].indices {
//            let indexPath = IndexPath(row: index, section: 0)
//            indexPathsToReload.append(indexPath)
//        }
        
        showIndexPaths = !showIndexPaths
        
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      tableView.estimatedRowHeight = 100
      tableView.sectionHeaderHeight = UITableViewAutomaticDimension
      tableView.backgroundView?.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
     tableView.backgroundView?.layer.borderWidth = 12
     tableView.backgroundView?.layer.cornerRadius = 1
      tableView.backgroundView?.layer.masksToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//      guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else {return HeaderView()}
      print("frame \(tableView.frame.width)")
      let headerView = UIView(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width, height: 50))
      
      headerView.layer.cornerRadius = 12
      headerView.layer.borderWidth = 1
      headerView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
      
      headerView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
      let showHideButton: UIButton = UIButton(frame: CGRect(x:headerView.frame.size.width - 100, y:10, width:100, height:28))
      
      let headerLabel = UILabel(frame: CGRect(x: 15, y: 10, width:
          tableView.bounds.size.width, height: 28))
      headerLabel.textColor = UIColor.black
      headerLabel.text = twoDimensionalArray[section].title
      headerLabel.textAlignment = .center
      headerView.addSubview(headerLabel)
            showHideButton.setImage(UIImage(named: "dropdowRed24X24"), for: .normal)
              showHideButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
      showHideButton.tag = section
      
      headerView.addSubview(showHideButton)
      
//          let frame: CGRect = tableView.frame

//      let button = UIButton(type: .custom)
////      button.frame = CGRect(x: 0, y: 0, width: tableView.frame.width - 30, height: 50)
////        button.setTitle("Close", for: .normal)
//      button.setImage(UIImage(named: "dropdowRed24X24"), for: .normal)
//        button.setTitleColor(.black, for: .normal)
////      button.lea
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//
//        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
//
//        button.tag = section
        
        return  headerView
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
//        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
      
//      button.setImage(isExpanded ? UIImage(name: "dropdowRed24X24") : UIImage(nam: "dropdowRed24X24") , for: .normal)
      let image = UIImage(named: "dropdowRed24X24")
      button.setImage(isExpanded ? image : image, for: .normal)
         
        if isExpanded {
          
//          let border = CALayer()
//          let width = CGFloat(2.0)
//          border.borderColor = UIColor.darkGray.cgColor
//          border.frame = CGRect(x: 0, y: tableView.frame.size.height - width, width:  tableView.frame.size.width, height: tableView.frame.size.height)
//
//          border.borderWidth = width
//          tableView.layer.addSublayer(border)
//          tableView.layer.masksToBounds = true
//          tableView.layer.cornerRadius = 12
//              tableView.layer.borderWidth = 1
//               tableView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
//          tableView.layer.masksToBounds = true
          tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
  
//
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 50 
  }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
     
        cell.textLabel?.text = name
        
        if showIndexPaths {
            cell.textLabel?.text = "\(name)   Section:\(indexPath.section) Row:\(indexPath.row)"
          
          
        }
        
        return cell
    }

}








