import Foundation

/// Gets the url for the heathcliff comic for the specified date
/// - Parameter date: Date to get the comic (defaults to today)
public func getHeathCliff(for date: Date = Date()) throws -> String {
    var imageURL: String
    let baseURL = "https://www.gocomics.com/heathcliff/"
    
    // split the date into ymd
    let stringDate = date.formatted(.iso8601).split(separator: "-")
    let year: String = String(stringDate[0])
    let month: String = String(stringDate[1])
    let day: String = String(stringDate[2].dropLast(10))
    
    // fetch the comic data
    guard let comicURL = URL(string: baseURL+"\(year)/\(month)/\(day)") else {
        throw URLError(.badURL)
    }
    
    let html = try String(contentsOf: comicURL)
    
    guard html.contains("data-image") else {
        throw URLError(.unknown)
    }
    
    let urlStart = html.range(of: "data-image")!.upperBound
    
    imageURL = html.suffix(from: urlStart).components(separatedBy: "\"")[1]
            
    return imageURL
}
