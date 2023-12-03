//
//  Helper.swift
//  Foods
//
//  Created by MAC on 02/12/2023.
//

import Foundation

class Helper{
    
    //MARK: - Methods

   static func convertISO8601DurationToTime(duration: String) -> String? {
        let iso8601Duration = duration.replacingOccurrences(of: "PT", with: "")
        
        if let minutesValue = iso8601Duration.replacingOccurrences(of: "M", with: "").toInt() {
            let hours = minutesValue / 60
            let minutes = minutesValue % 60
            
            return String(format: "%02d:%02d", hours, minutes)
        }
        
        return nil
    }
}

//MARK: -Extension

extension String {
    func toInt() -> Int? {
        return Int(self)
    }
}
