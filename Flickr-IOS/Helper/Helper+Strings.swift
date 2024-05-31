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
        guard let data = self.data(using: .utf8) else { return self }
        
        if let attributedString = try? NSAttributedString(data: data,
                                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                                          documentAttributes: nil) {
            return attributedString.string
        } else {
            return self
        }
    }
}
