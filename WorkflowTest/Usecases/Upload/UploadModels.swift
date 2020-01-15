import Foundation

enum EvidenceType: CaseIterable {
    case passport, id, drivingLicence
}

typealias AllowedEvidenceTypes = [EvidenceType]

struct UploadPayload {
    var id: String = UUID().uuidString
    let evidences: [EvidenceType]
    var numberOfPages = 0 // letters
    var letter: Bool { numberOfPages > 0 }
    var selfie: Bool { selfieType != nil }
    var selfieType: SelfieCaptureRequirements? = nil
    var geolocation = false
    var notify = false
}

extension UploadPayload {
    var letterRequirements: LetterCapture? {
        guard letter else { return nil }

        let pages = (1...numberOfPages).map({ i in
            LetterPageCapture(page: i, pages: numberOfPages)
        })
        return LetterCapture(
            id: id,
            pages: pages
        )
    }
}
