//
//  DispatchQueue+Ex.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

extension DispatchQueue {
    func async(delayed seconds: Double,
               execute closure: @escaping ()->()){
        if seconds < 0 {
            async(execute: closure)
        } else {
            let when = DispatchTime.now() + seconds
            
            asyncAfter(deadline: when, execute: closure)
        }
    }
}

private func delay(_ seconds: Double,
                   onQueue queue: DispatchQueue,
                   execute closure: @escaping ()->()){
    queue.async(delayed: seconds, execute: closure)
}

public func delay(_ seconds: Double,
                  execute closure:@escaping ()->()){
    delay(seconds, onQueue: DispatchQueue.main, execute: closure)
}


extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

    /* //Usage
     
     DispatchQueue.background(delay: 3.0, background: {
         // do something in background
     }, completion: {
         // when background job finishes, wait 3 seconds and do something in main thread
     })

     DispatchQueue.background(background: {
         // do something in background
     }, completion:{
         // when background job finished, do something in main thread
     })

     DispatchQueue.background(delay: 3.0, completion:{
         // do something in main thread after 3 seconds
     })
     
     */
}
