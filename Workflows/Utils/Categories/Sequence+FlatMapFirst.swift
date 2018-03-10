import Foundation

extension Sequence {
    func flatMapFirst<T>(_ transform: (Element) throws -> T?) -> T? {
        for element in self {
            do {
                let element = try transform(element)
                if element != nil {
                    return element
                }
            } catch {
                // empty on purpose
            }
        }
        return nil
    }
}
