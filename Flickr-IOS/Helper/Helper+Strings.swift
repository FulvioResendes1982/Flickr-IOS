import Foundation

extension String {
    func formattedDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let dateObject = inputFormatter.date(from: self) else {
            return "Unkown date"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMM y"
        
        return outputFormatter.string(from: dateObject)
    }
        
    func strippingHTML() -> String {                
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
