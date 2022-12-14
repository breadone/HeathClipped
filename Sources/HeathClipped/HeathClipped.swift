import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@available(macOS 10.12, *)
/// Gets the url for the heathcliff comic for the specified date
/// - Parameter date: Date to get the comic (defaults to today)
public func getHeathCliff(for date: Date = Date()) throws -> String {
    var imageURL: String
    
    // split the date into ymd
    let stringDate = date.iso8601().split(separator: "-")
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

@available(macOS 10.12, *)
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

@available(macOS 10.12, *)
// i could not for the life of me tell you why this is needed but apparently .ISO8601Format just does not exist o k a y
extension Date {
    func iso8601() -> String {
        return ISO8601DateFormatter().string(from: self)
    }
}
