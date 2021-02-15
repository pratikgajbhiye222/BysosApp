//
//  Model.swift
//  DiffableCollectionViewInSwift
//
//  Created by BYSOS 2019 on 15/02/21.
//

import Foundation

//MARK:- SectionLayout
enum SectionLayout: Hashable, CaseIterable {
    case storiesCarousel
    case contestCarousel
    case bannerCarousel
    
    
    
    var sectionTitle: String {
      switch self {
      case .storiesCarousel:
        return "My Contest"
      case .contestCarousel:
        return " "
      case .bannerCarousel:
        return "Upcoming Contest"
      }
    }
    
}
//MARK:- UpdatedDifferent DataSource

struct ContestNewList: Codable ,Hashable {
    let status, message: String?
    let data: DataForContest?
    
        func hash(into hasher: inout Hasher) {
            hasher.combine(status)
        }
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.status == rhs.status &&
            lhs.message == rhs.message &&
            lhs.data == rhs.data
    }
    
}

// MARK: - DataClass
struct DataForContest: Codable , Hashable{
    let contests : [HeadContest]?
    let myContest: [MyContest]?
    let banners: [Banner]?
        func hash(into hasher: inout Hasher) {
            hasher.combine(contests)
        }
        static func ==(lhs: Self, rhs: Self) -> Bool {
            lhs.contests == rhs.contests &&
                lhs.myContest == rhs.myContest &&
                lhs.banners == rhs.banners
        }
    
}


// MARK: - MyContestElement
struct MyContest: Codable , Hashable {
    let id, fixtureId, masterfixtureid: Int?
    let title, startTime, endTime: String?
    let contest: [ContestContest]?

    enum CodingKeys: String, CodingKey {
        case id
        case fixtureId
        case masterfixtureid, title, startTime, endTime, contest
    }
}

struct HeadContest: Codable , Hashable {
    let id, fixtureId, masterfixtureid: Int?
    let title, startTime, endTime: String?
    let contest: [HeadContestDetails]?

    enum CodingKeys: String, CodingKey {
        case id
        case fixtureId
        case masterfixtureid, title, startTime, endTime, contest
    }
}

// MARK: - ContestContest
struct ContestContest: Codable , Hashable {
    let contestID: Int?
    let mastercontestID, title, prize: String?
    let team, spotLeft, entryprice, fixtureID: Int?
    let adminfee, instructions, fixture: String?
    let distribute: Int?
    let startTime, endTime: String?

    enum CodingKeys: String, CodingKey {
        case contestID = "contestId"
        case mastercontestID = "mastercontestId"
        case title, prize, team, spotLeft, entryprice
        case fixtureID = "fixtureId"
        case adminfee, instructions, fixture, distribute, startTime, endTime
    }
}

struct HeadContestDetails: Codable , Hashable {
    let contestID: Int?
    let mastercontestID, title, prize: String?
    let team, spotLeft, entryprice, fixtureID: Int?
    let adminfee, instructions, fixture: String?
    let distribute: Int?
    let startTime, endTime: String?

    enum CodingKeys: String, CodingKey {
        case contestID = "contestId"
        case mastercontestID = "mastercontestId"
        case title, prize, team, spotLeft, entryprice
        case fixtureID = "fixtureId"
        case adminfee, instructions, fixture, distribute, startTime, endTime
    }
}



// MARK: - Banner
struct Banner: Codable , Hashable {
    let id: String?
    let bannerId: Int?
    let image: String?
    let position: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case bannerId
        case image, position
    }
}
