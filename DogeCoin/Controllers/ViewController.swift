//
//  ViewController.swift
//  DogeCoin
//
//  Created by Apple on 27/01/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    
   let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()
    var data:DogeCoinModel?
    private var viewmodel = [dogecointableviewmodel]()
    
    private let tableview: UITableView = {
        let table = UITableView()
        table.register(DogeTableViewCell.self, forCellReuseIdentifier: DogeTableViewCell.identifier)
        
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
            
          
          fetchdata()
   
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        
    }
    func data2() {
        
        guard let datas = data else {
                 
               return
                 
             }
        viewmodel = [  dogecointableviewmodel(title: "Name",   value: datas.name ),
                       dogecointableviewmodel(title: "symbol", value: datas.symbol),
                       dogecointableviewmodel(title: "DateAdded", value: datas.date_added),
                       dogecointableviewmodel(title: "DateAdded", value: String(datas.id))]
                            
             
        createtableview()
    }
  
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    
    func createtableview() {
        
        //update viewmodels
   
        guard let price = data?.quote["USD"]?.price else {return}
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        header.clipsToBounds  = true
        let imageview = UIImageView(image: UIImage(named: "doge"))
        imageview.contentMode = .scaleAspectFit
        let size:CGFloat = view.frame.size.width/4
        imageview.frame = CGRect(x: (view.frame.size.width-size)/2, y: 10, width: size, height: size)
        header.addSubview(imageview)
        tableview.tableHeaderView = header
        
        
        
        let number = NSNumber(value: price)
        let string = self.formatter.string(from: number)
        let label = UILabel()

        label.text = string
        label.font = .systemFont(ofSize: 22,weight:.medium)
        label.textAlignment = .center
        label.frame = CGRect(x: 10, y: 20+size, width: view.frame.size.width-20, height: 120)

        header.addSubview(label)
        view.backgroundColor = .black
        view.addSubview(tableview)
        tableview.delegate =  self
        tableview.dataSource = self
   
    }
    
     func fetchdata() {
        APICaller.shared.getdata { [weak self]results in
            switch results{
            case.success(let data):
                self?.data = data
              
                DispatchQueue.main.async {
                    self?.data2()
                    
                
                    
                }
            case.failure(let error):
                print(error)
            }
            
        }
      
    }
   
   
 }


extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard  let cell = tableview.dequeueReusableCell(withIdentifier: DogeTableViewCell.identifier, for: indexPath)
        as? DogeTableViewCell else {
        fatalError()
            
        }
        cell.configure(with: viewmodel[indexPath.row])
        return cell
    }
    
    
    
    
}
