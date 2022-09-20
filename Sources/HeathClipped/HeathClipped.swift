import Foundation

/// Gets the url for the heathcliff comic for the specified date
/// - Parameter date: Date to get the comic (defaults to today)
func getHeathCliff(for date: Date = Date()) {
    // split the date into ymd
    let stringDate = date.formatted(.iso8601).split(separator: "-")
    let year: String = String(stringDate[0])
    let month: String = String(stringDate[1])
    let day: String = String(stringDate[2].dropLast(10))
    
    // fetch the comic data
    let comicURL = URL(string: "https://www.gocomics.com/heathcliff/\(year)/\(month)/\(day)")!
    let html: String
    
    do {
        html = try String(contentsOf: comicURL)
    } catch {
        fatalError("Failed to parse URL: \(error.localizedDescription)")
    }
    
    print(html)
    
}
