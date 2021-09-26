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
        guard let textSearch = textSearch { throw ValidationError.invalidValue }
        guard textSearch.rangeOfCharacter(from: characterset.inverted) == nil { throw ValidationError.textHasSpecialCharacter}
        return textSearch
    }
}
