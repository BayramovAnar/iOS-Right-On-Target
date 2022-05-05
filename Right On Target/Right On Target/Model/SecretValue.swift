//
//  SecretValue.swift
//  Right On Target
//
//  Created by Anar Bayramov on 5/2/22.
//

import Foundation


typealias SecretNumericValue = SecretValue<Int>
typealias SecretColorValue = SecretValue<Color>

protocol SecretValueProtocol{
    associatedtype ValueType
    var value: ValueType {get}
    mutating func setRandomValue()
}

struct SecretValue<T: Equatable>: SecretValueProtocol{
    var value: T
    
    typealias ValueType = T
    private let randomValueClosure: (T) -> T
    
    init(initialValue: T, randomValueClosure: @escaping (T) -> T){
        value = initialValue
        self.randomValueClosure = randomValueClosure
    }
    
    mutating func setRandomValue() {
        self.value = randomValueClosure(self.value)
    }
}
