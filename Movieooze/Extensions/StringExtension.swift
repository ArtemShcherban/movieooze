//
//  StringExtension.swift
//  Movieooze
//
//  Created by Artem Shcherban on 11.09.2021.
//

import Foundation


extension String {
subscript (r: Range<Int>) -> String? {
        guard r.lowerBound >= 0 && r.upperBound <= self.count else { return self }
        let firstCharacter = self.index(startIndex, offsetBy: r.lowerBound)
        let lastCharacter = self.index(startIndex, offsetBy: r.upperBound)
        let range = firstCharacter..<lastCharacter
        let mySubString = self[range]
        let myString = String(mySubString) + "..."
        return myString
    }

}
