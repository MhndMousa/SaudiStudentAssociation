//
//  FullPhotoTableViewCell.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 9/4/19.
//  Copyright © 2019 Muhannad Mousa. All rights reserved.
//

import UIKit

class FullPhotoTableViewCell: UITableViewCell {

    lazy var backgroundImageView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "car2")
        view.backgroundColor = .black
        view.contentMode = UIViewContentMode.scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var blackView : UIView = {
       let v = UIView()
        v.alpha = 0.85
        v.backgroundColor = .black
        return v
    }()
    
    lazy var headlineLabel : UILabel = {
        let label = UILabel()
        label.text = "عنوان"
        label.textColor = .white
        label.font = UIFont.notoKufiBoldArabicMediumLarge
        label.textAlignment = NSTextAlignment.natural
        return label
    }()

    lazy var catagory : UILabel = {
        let label = UILabel()
        label.text = "نوع السلعة"
        label.textColor = .white
        label.font = UIFont.notoKufiArabicSmall
        label.textAlignment = NSTextAlignment.natural
        return label
    }()
    lazy var icon : UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "flappy")
//        icon.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        return icon
    }()
    
    lazy var stackView: UIStackView = {
        let a = UIStackView()
        a.axis = .vertical
        
        if #available(iOS 9.0, *) {
            if UIView.userInterfaceLayoutDirection(for: a.semanticContentAttribute) == .rightToLeft {
                a.alignment = UIStackViewAlignment.trailing
            }else{
                a.alignment = UIStackViewAlignment.leading
            }
        } else {
            if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
                a.alignment = UIStackViewAlignment.trailing
            }else{
                a.alignment = UIStackViewAlignment.leading
            }
        }
        a.distribution = UIStackViewDistribution.fill
        a.spacing = 6
        return a
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(blackView)
        blackView.addSubview(stackView)
        
        stackView.addArrangedSubview(headlineLabel)
        stackView.addArrangedSubview(catagory)
        stackView.addArrangedSubview(icon)
        
        backgroundImageView.fillSuperView()
        blackView.fillSuperView()

        stackView.anchor(leading: blackView.leadingAnchor, trailing: blackView.trailingAnchor, centery: blackView.centerYAnchor, padding: .init(top: 20, left: 20, bottom: 40, right: 40))
        icon.anchor(size: .init(width: 20, height: 20))
        
        //        headlineLabel.anchor(top: blackView.topAnchor, leading: blackView.leadingAnchor, bottom: catagory.topAnchor, trailing: blackView.trailingAnchor, padding: .init(top: 50, left: 20, bottom: 0, right: 0))
//        catagory.anchor(top: headlineLabel.bottomAnchor, leading: icon.trailingAnchor,  trailing: headlineLabel.trailingAnchor)
////        icon.anchor(top: nil, leading: headlineLabel.leadingAnchor, bottom: nil, trailing: catagory.leadingAnchor, size: CGSize(width: 20, height: 20))
//
//        icon.anchor( leading: headlineLabel.leadingAnchor,  trailing: catagory.leadingAnchor,  centery: catagory.centerYAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: -9),size: CGSize(width: 20, height: 20))
//
//        createGradientView()
        
    }

    func createGradientView(){
        let g = CAGradientLayer()
        g.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        g.locations = [0.75,1]
        let gView = UIView()
        insertSubview(gView, aboveSubview: backgroundImageView)
        gView.fillSuperView()
        gView.alpha = 0.8
        gView.layer.addSublayer(g)
        g.frame = bounds



    }
    
}
