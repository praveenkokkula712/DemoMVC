//
//  ViewController.swift
//  Demo_MVC
//
//  Created by Praveen Kokkula on 22/01/21.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView?
    var dataModel:[Model]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.callAPI()
    }

    private func setupTableView() {
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView?.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.view.addSubview(self.tableView ?? UITableView())
        self.tableView?.reloadData()
    }
    
    private func callAPI() {
        
        ModelService.shared.call(urlString: urlString) { (model) in
            DispatchQueue.main.async {
                self.dataModel = model
                self.tableView?.reloadData()
            }
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? CustomTableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.dataModel?[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        cell.detailTextLabel?.text = self.dataModel?[indexPath.row].body
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        
        return cell
    }

}

class CustomTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
