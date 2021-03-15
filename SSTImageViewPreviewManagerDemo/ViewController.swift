//
//  ViewController.swift
//  SSTImageViewPreviewManagerDemo
//
//  Created by SST on 3/15/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
   
    var index = 0
    
    var listView: UICollectionView?
    var manager: SSTImageViewPreviewManager?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

       
        //布局 这里先用系统的，后面打算再自定义一个layout
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
   
        layout.itemSize = CGSize.init(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let listView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        listView.dataSource = self
        listView.delegate = self
        listView.backgroundColor = .white
        listView.isScrollEnabled = false
        listView.register(SSTCollectionViewCell.self, forCellWithReuseIdentifier:"identifier")
        self.listView = listView
        
        self.view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SSTCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! SSTCollectionViewCell

        cell.imageView.image = UIImage(named: "TestImage")


        
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        index = indexPath.row
        
        let cell: SSTCollectionViewCell = collectionView.cellForItem(at: indexPath) as! SSTCollectionViewCell

        
        if manager == nil {
            self.manager = SSTImageViewPreviewManager.init()

        }
        

        

        manager!.previewImageView(imageView: cell.imageView) {


            self.bigImageView.isHidden = false

            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

            
            window?.addSubview(self.bigImageView)
            self.bigImageView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            self.bigImageView.image = cell.imageView.image



        }

    }
    
    @objc  func hiddenBigImageView() {
        
        bigImageView.isHidden = true
        bigImageView.removeFromSuperview()
        let toCell: SSTCollectionViewCell = listView!.cellForItem(at: IndexPath(row: index, section: 0)) as! SSTCollectionViewCell
        manager!.resertImageView(imageView: toCell.imageView)

        
    }
    
    
    lazy var bigImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(hiddenBigImageView))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()

}




