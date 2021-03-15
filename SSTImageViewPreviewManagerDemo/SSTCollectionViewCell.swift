//
//  SSTCollectionViewCell.swift
//  SSTImageViewPreviewManagerDemo
//
//  Created by 梅琰培 on 3/15/21.
//

import UIKit
import SnapKit

class SSTCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadInitializeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadInitializeView() {
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
