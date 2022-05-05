//
//  GameFactory.swift
//  Right On Target
//
//  Created by Anar Bayramov on 5/2/22.
//

import Foundation


//this class corresponds to the design pattern "abstract factory"

final class GameFactory{
    static func getNumericGame() -> some GameProtocol{
        let minSecretValue = 1
        let maxSecretValue = 50
        let secretValue = SecretNumericValue(initialValue: 0){ _ in
            return Array(minSecretValue ... maxSecretValue).randomElement()!
        }
        
        return Game<SecretNumericValue>(secretValue: secretValue, rounds: 5){ secretValue, userValue in var compareResults: Int!
            if secretValue.value == userValue.value{
                compareResults = maxSecretValue
            }else if secretValue.value > userValue.value{
                compareResults = maxSecretValue - (secretValue.value - userValue.value)
            }else if secretValue.value < userValue.value{
                compareResults = maxSecretValue - (userValue.value - secretValue.value )
        }
        return compareResults
    }
}
    
    static func getColorGame() -> some GameProtocol{
        let initialSecretColor = Color()
        let secretValue = SecretColorValue(initialValue: initialSecretColor){ color in
            var updatedColor = color
            updatedColor.red = Array(0 ... 255).randomElement()!
            updatedColor.green = Array(0 ... 255).randomElement()!
            updatedColor.blue = Array(0 ... 255).randomElement()!
            return updatedColor
        }
        
        return Game<SecretColorValue>(secretValue: secretValue, rounds: 5){secretValue, userValue in
            if secretValue.value == userValue.value{
                return 1
            }else{
                return 0
            }
        }
    }
}
