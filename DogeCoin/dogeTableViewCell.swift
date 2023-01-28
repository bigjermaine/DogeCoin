//
//  dogeTableViewCell.swift
//  DogeCoin
//
//  Created by Apple on 28/01/2023.
//


import UIKit

struct dogecointableviewmodel {
    
    let title:String
    let value:String
    
    
}

class DogeTableViewCell: UITableViewCell {
    
static let identifier = "DogeTableViewCell"
    
    private let label:UILabel = {
        let label = UILabel()
      return label
    }()
    private let label2:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
      return label
    }()
    
    
    override  init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(label2)
        
    }
    
    
    
    required init?(coder:NSCoder){
        
        fatalError()
    }
    
    
    override  func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label2.sizeToFit()
        label.frame = CGRect(x: 15, y: 0, width: label.frame.size.width, height: contentView.frame.size.height)
        label2.frame = CGRect(x:contentView.frame.size.width - 15 - label2.frame.size.width, y: 0, width: label2.frame.size.width, height: contentView.frame.size.height)
    }
    
    
    func configure(with model: dogecointableviewmodel) {
        label.text = model.title
        label2.text = model.value
        
    }
}
