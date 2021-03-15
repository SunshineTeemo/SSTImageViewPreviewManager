//
//  SSTImageViewPreviewManager.swift
//  AdoptionPlatform
//
//  Created by SST on 12/17/20.
//  Copyright © 2020 SunshineTeemo. All rights reserved.
//

import UIKit

/// 图片点击放大后其他视图横向展示的工具
class SSTImageViewPreviewManager: NSObject {
    
    let ScreenWidth = UIScreen.main.bounds.size.width

    let ScreenHeight = UIScreen.main.bounds.size.height
    
    
    /// 放大缩小的图片imageView
    var placeHolderImageView = UIImageView.init()
    
    /// 背景黑图
    let backgroundView = UIView.init()
    
   
    
    
    /// 动画时间
    let animationSecond = 0.2
    
    
    
    
    
    /// 放大图片的方法
    /// - Parameters:
    ///   - imageView: 点击需放大的图片
    ///   - completion: 放大动画完成后回调的block，这里建议写放大后显示视图的展示，比如bigView.show()
    func previewImageView(imageView: UIImageView, completion:@escaping ()-> Void){
        
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        let orginalFrame = imageView.superview?.convert(imageView.frame, to: window)
        
        
        backgroundView.backgroundColor = UIColor(red: 13/255.0, green: 14/255.0, blue: 15/255.0, alpha: 1)
        backgroundView.alpha = 0
        

        placeHolderImageView = UIImageView.init(image: imageView.image)
        
        placeHolderImageView.contentMode = .scaleAspectFill
        placeHolderImageView.clipsToBounds = true
        
        
        window?.addSubview(backgroundView)
        backgroundView.addSubview(placeHolderImageView)
        
        
        backgroundView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        placeHolderImageView.snp.makeConstraints { (make) in
            make.top.equalTo(Float(orginalFrame?.origin.y ?? 0))
            
            make.left.equalTo(Float(orginalFrame?.origin.x ?? 0))
            make.width.equalTo(Float(orginalFrame?.size.width ?? 0))
            make.height.equalTo(Float(orginalFrame?.size.height ?? 0))

        }
        
        
        //计算高度
        let scale = placeHolderImageView.image!.size.height/placeHolderImageView.image!.size.width
        
        
        let height = scale*ScreenWidth
                
        
        //放大动画，最终的坐标值
        let toFrame =  CGRect.init(x: 0.00, y: (ScreenHeight-height)/2, width: ScreenWidth, height: height)

        
        //这句话必须写，不写就看不到因为约束变化生成的动画
        placeHolderImageView.superview!.layoutIfNeeded()

        UIView.animate(withDuration: animationSecond, animations: {


            self.placeHolderImageView.snp.updateConstraints { (make) in
                make.top.equalTo(toFrame.origin.y)
                make.left.equalTo(toFrame.origin.x)
                make.width.equalTo(toFrame.size.width)
                make.height.equalTo(toFrame.size.height)

            }
            self.backgroundView.alpha = 1

            self.placeHolderImageView.superview!.layoutIfNeeded()




        }) { (isFinish) in

            
            
            
            completion()


        }
        
        
        
    }
    
    
    
    /// 放大后的视图点击返回按钮或者再次点击图片，图片预览还原的时候调用
    /// 放大的视图一般有左右滑动的功能，这样的话，我们滑动的后还原的图片就不一定是我们原先放大的图片，所以这里的imageView需要传应返回的imageView
    /// - Parameter imageView: 这里传应返回至哪个位置图片的imageviwe
    func  resertImageView(imageView: UIImageView) {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        
        let toFrame = imageView.superview?.convert(imageView.frame, to: window)
        

        
        placeHolderImageView.image = imageView.image
        
        
        placeHolderImageView.superview?.layoutIfNeeded()
        
        
        UIView.animate(withDuration: animationSecond) {
            
            self.placeHolderImageView.snp.updateConstraints { (make) in
                
                make.top.equalTo(toFrame?.origin.y ?? 0)
                make.left.equalTo(toFrame?.origin.x ?? 0)
                make.width.equalTo(toFrame?.size.width ?? 0)
                make.height.equalTo(toFrame?.size.height ?? 0)
                
            
            }
            
            self.backgroundView.alpha = 0
            
            self.placeHolderImageView.superview?.layoutIfNeeded()
            
        } completion: { (isFinisha) in
            
            
            self.backgroundView.removeFromSuperview()
            self.placeHolderImageView.removeFromSuperview()
            
        }

        
        
        
        //qqqq
        
        
        
    }
    
    

}
