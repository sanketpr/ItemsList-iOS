import Foundation

typealias JSONDict = [String: Any]

class NetworkRequestHandler {

    private let itemsListURL = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json")!

    func  fetchItemsList(completion: @escaping ([Item]) -> ()) {
        URLSession.shared.dataTask(with: itemsListURL) { data, _, _ in

            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let itemsDict = json as! [JSONDict]
                let itemsList = itemsDict.compactMap(Item.init)

                DispatchQueue.main.async {
                    completion(itemsList)
                }
            }
        }.resume()
    }
}
