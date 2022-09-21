import Foundation

/// Gets the url for the heathcliff comic for the specified date
/// - Parameter date: Date to get the comic (defaults to today)
public func getHeathCliff(for date: Date = Date()) throws -> String {
    var imageURL: String
    
    // split the date into ymd
    let stringDate = date.ISO8601Format().split(separator: "-")
    let year: String = String(stringDate[0])
    let month: String = String(stringDate[1])
    let day: String = String(stringDate[2].dropLast(10))
    
    // fetch the comic data
    guard let comicURL = URL(string: "https://www.gocomics.com/heathcliff/\(year)/\(month)/\(day)") else {
        throw URLError(.badURL)
    }
    
    let html = try String(contentsOf: comicURL)
    
    // if this fails then theres no comic for the entered date
    guard html.contains("data-image") else {
        print("No comic for this date!")
        throw URLError(.unknown)
    }
    
    let urlStart = html.range(of: "data-image")!.upperBound
    
    imageURL = html.suffix(from: urlStart).components(separatedBy: "\"")[1]
            
    return imageURL
}

public func getHeathCliff(year: String, month: String, day: String) throws -> String {
    let imageURL: String
    
    // fetch the comic data
    guard let comicURL = URL(string: "https://www.gocomics.com/heathcliff/\(year)/\(month)/\(day)") else {
        throw URLError(.badURL)
    }
    
    let html = try String(contentsOf: comicURL)
    
    // if this fails then theres no comic for the entered date
    guard html.contains("data-image") else {
        print("No comic for this date!")
        throw URLError(.unknown)
    }
    
    let urlStart = html.range(of: "data-image")!.upperBound
    
    imageURL = html.suffix(from: urlStart).components(separatedBy: "\"")[1]
            
    return imageURL
}

/// Gets the url for the heathcliff comic for the specified date
/// - Parameter date: Date to get the comic (defaults to today)
public func getHeathCliffURL(for date: Date = Date()) throws -> URL {
    let string: String = try getHeathCliff(for: date)
    
    if let url = URL(string: string) {
        return url
    } else {
        throw URLError(.badURL)
    }
}
