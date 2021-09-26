//
//  ValidationSearch.swift
//  challenge-mobile2you
//
//  Created by Softbuilder Hibrido on 26/09/21.
//

import Foundation

struct ValidationSearch {
    func validateSearchText(_ textSearch: String?) throws -> String {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
//        if textSearch?.rangeOfCharacter(from: characterset.inverted) != nil {
//            print("string contains special characters")
//        }
        guard let textSearch = textSearch else { throw ValidationError.invalidValue }
        guard textSearch.rangeOfCharacter(from: characterset.inverted) == nil else { throw ValidationError.textHasSpecialCharacter}
        return textSearch
    }
}

enum ValidationError: LocalizedError {
    case textHasSpecialCharacter
    case invalidValue
    
    var errorDescription: String? {
        switch self {
        case .textHasSpecialCharacter:
            return "You have entered a special character!"
        case .invalidValue:
            return "You have entered an invalid value"
        }
    }
}
