//
//  RecordListViewController.swift
//  MemoryMatch
//
//  Created by czf on 2018/12/1.
//  Copyright © 2018年 czf. All rights reserved.
//

import UIKit

class RecordListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        return score.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let CellIdentifier:String = "Cell"
        let dequedCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? UITableViewCell
        let cell = dequedCell ?? UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: CellIdentifier) as UITableViewCell
        
        //if(indexPath.row==0){
        //    cell.textLabel?.text = "POG Validation"
        //    cell.imageView?.image = UIImage(named: "myImg")
        //}
        //var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        //check if nil
        //if cell == nil {
        //    cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        //}
        cell.textLabel?.text = "\(score.object(at: indexPath.row))"
        //cell.textLabel?.text = "1"
   //     return cell!
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
