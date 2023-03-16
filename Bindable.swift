//
//  Bindable.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 14.03.2023.
//

import Foundation


class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
