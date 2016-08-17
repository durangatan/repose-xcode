/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class TileGridView: UIView {
  
  private var containerView: UIView!
  private var modelTileView: TileView!
  private var centerTileView: TileView? = nil
  private var numberOfRows = 0
  private var numberOfColumns = 0
  
  private var logoLabel: UILabel!
  private var tileViewRows: [[TileView]] = []
  private var beginTime: CFTimeInterval = 0
  private let kRippleDelayMultiplier: NSTimeInterval = 0.0000
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerView.center = center
    modelTileView.center = containerView.center
    if let centerTileView = centerTileView {
      // Custom offset needed for UILabel font
      let center = CGPoint(x: CGRectGetMidX(centerTileView.bounds) + 31, y: CGRectGetMidY(centerTileView.bounds))
      logoLabel.center = center
    }
  }
  
  init(TileFileName: String) {
    modelTileView = TileView(TileFileName: TileFileName)
    super.init(frame: CGRect.zero)
    clipsToBounds = true
    layer.masksToBounds = true
    
    containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 630.0, height: 990.0))
    containerView.backgroundColor = UIColor.clearColor()
    containerView.clipsToBounds = false
    containerView.layer.masksToBounds = false
    addSubview(containerView)
    
    renderTileViews()
    
    logoLabel = generateLogoLabel()
    centerTileView?.addSubview(logoLabel)
    layoutIfNeeded()
  }
  
  func startAnimating() {
    beginTime = CACurrentMediaTime()
    startAnimatingWithBeginTime(beginTime)
  }
}

extension TileGridView {
  
  private func generateLogoLabel()->UILabel {
    let label = UILabel()
    label.text = "   R E P     S E        "
    label.font = UIFont.systemFontOfSize(50)
    label.textColor = UIColor.whiteColor()
    label.sizeToFit()
    label.center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
    return label
  }
  
  private func renderTileViews() {
    let width = CGRectGetWidth(containerView.bounds)
    let height = CGRectGetHeight(containerView.bounds)
    
    let modelImageWidth = CGRectGetWidth(modelTileView.bounds)
    let modelImageHeight = CGRectGetHeight(modelTileView.bounds)
    
    numberOfColumns = Int(ceil((width - modelTileView.bounds.size.width / 2.0) / modelTileView.bounds.size.width))
    numberOfRows = Int(ceil((height - modelTileView.bounds.size.height / 2.0) / modelTileView.bounds.size.height))
    
    for y in 0..<numberOfRows {
      
      var tileRows: [TileView] = []
      for x in 0..<numberOfColumns {
        
        let view = TileView()
        view.frame = CGRect(x: CGFloat(x) * modelImageWidth, y:CGFloat(y) * modelImageHeight, width: modelImageWidth, height: modelImageHeight)
        
        if view.center == containerView.center {
          centerTileView = view
        }
        
        containerView.addSubview(view)
        tileRows.append(view)
        
        if y != 0 && y != numberOfRows - 1 && x != 0 && x != numberOfColumns - 1 {
          view.shouldEnableRipple = true
        }
      }
      
      tileViewRows.append(tileRows)
    }
    
    if let centerTileView = centerTileView {
      containerView.bringSubviewToFront(centerTileView)
    }
  }
  
  private func startAnimatingWithBeginTime(beginTime: NSTimeInterval) {
    
    for tileRows in tileViewRows {
        for view in tileRows {
            view.startAnimatingWithDuration(kAnimationDuration, beginTime: beginTime, rippleDelay: 0, rippleOffset: CGPointZero)
        }
    }
    
    
  }
  
}

