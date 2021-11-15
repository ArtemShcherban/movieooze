//
//  File.swift
//  Movieooze
//
//  Created by Artem Shcherban on 05.10.2021.
//

import Foundation
import UIKit

struct StarsLevel {
    
 static  func movieOrTvShowStarsLevel(level: Double) -> UIImage? {
       
        var starsLevelResult = UIImage(named: "fi-rr-0_5star_orange")
        
        switch level {
        case 9.5...10:
            starsLevelResult = UIImage(named: "fi-rr-5stars_orange")
        case 8.5..<9.5:
            starsLevelResult = UIImage(named: "fi-rr-4_5stars_orange")
        case 7.5..<8.5:
            starsLevelResult = UIImage(named: "fi-rr-4stars_orange")
        case 6.5..<7.5:
            starsLevelResult = UIImage(named: "fi-rr-3_5stars_orange")
        case 5.5..<6.5:
            starsLevelResult = UIImage(named: "fi-rr-3stars_orange")
        case 4.5..<5.5:
            starsLevelResult = UIImage(named: "fi-rr-2_5stars_orange")
        case 3.5..<4.5:
            starsLevelResult = UIImage(named: "fi-rr-2stars_orange")
        case 2.5..<3.5:
            starsLevelResult = UIImage(named: "fi-rr-1_5stars_orange")
        case 1.5..<2.5:
            starsLevelResult = UIImage(named: "fi-rr-star_orange")
        case 0.0..<1.5:
            starsLevelResult = UIImage(named: "fi-rr-0_5star_orange")
        default:
            break
        }
        return starsLevelResult
    }
}
