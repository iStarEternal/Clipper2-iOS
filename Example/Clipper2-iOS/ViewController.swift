//
//  ViewController.swift
//  Clipper2-iOS
//
//  Created by hyh on 02/13/2025.
//  Copyright (c) 2025 hyh. All rights reserved.
//

import UIKit
import Clipper2_iOS


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let path1 = UIBezierPath()
        let paht2 = UIBezierPath()
        
        Clipper2Wrapper.xorPath(withPath1: path1.cgPath, path2: paht2.cgPath)
        Clipper2Wrapper.xorPath(withPath1: path1.cgPath, path2: paht2.cgPath)
        Clipper2Wrapper.xorPath(withPath1: path1.cgPath, path2: paht2.cgPath)
        Clipper2Wrapper.xorPath(withPath1: path1.cgPath, path2: paht2.cgPath)
        
        
        let tv = TestView()
        
        view.addSubview(tv)
        view.backgroundColor = UIColor.white
        tv.frame = view.bounds
        
        tv.backgroundColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}



class TestView: UIView {
    
    override func draw(_ rect: CGRect) {
        // 创建一个圆形路径
//        let circlePath = UIBezierPath(ovalIn: CGRect(x: 50, y: 50, width: 100, height: 100))
        let rectPath1 = UIBezierPath(rect: CGRect(x: 50, y: 50, width: 100, height: 100))
        
        // 创建一个矩形路径
        let rectPath2 = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        // 使用 Clipper2Wrapper 进行 XOR 路径操作，返回一个 Unmanaged<CGPath>
//        let xorPath = Clipper2Wrapper.unionPath(withPath1: circlePath.cgPath, path2: rectPath.cgPath)
        let xorPath = Clipper2Wrapper.v3_xorPath(withPath1: rectPath1.cgPath, path2: rectPath2.cgPath)
        
        // 获取 XOR 路径并转换为 UIBezierPath
        let path = UIBezierPath(cgPath: xorPath.takeRetainedValue())
        
        // 设置填充颜色
//        UIColor.red.setFill()
//
//        rectPath1.fill()
//        rectPath2.fill()
        // 填充路径
        
        UIColor.black.setFill()
        path.fill()
        
        // 可选：设置路径的边框颜色
//        UIColor.black.setStroke()
//        path.lineWidth = 2
//        path.stroke()
    }
    
}
