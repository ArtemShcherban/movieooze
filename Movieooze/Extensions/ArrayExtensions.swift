//
//  ArrayExtensions.swift
//  Movieooze
//
//  Created by Artem Shcherban on 11.09.2021.
//

import Foundation

extension Array {
    public func toDictionary<Key : Hashable>(with selectKey: (Element) -> Key) -> [Key : Element] {
        var dict = [Key : Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
