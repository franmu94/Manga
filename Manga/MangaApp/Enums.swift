//
//  Enums.swift
//  MangaApp
//
//  Created by Fran Malo on 30/5/24.
//

import Foundation

enum Theme: String, CaseIterable, Codable, Identifiable {
    var id: Self { self }
    case gore = "Gore"
    case military = "Military"
    case mythology = "Mythology"
    case psychological = "Psychological"
    case historical = "Historical"
    case samurai = "Samurai"
    case romanticSubtext = "Romantic Subtext"
    case school = "School"
    case adultCast = "Adult Cast"
    case parody = "Parody"
    case superPower = "Super Power"
    case teamSports = "Team Sports"
    case delinquents = "Delinquents"
    case workplace = "Workplace"
    case survival = "Survival"
    case childcare = "Childcare"
    case iyashikei = "Iyashikei"
    case reincarnation = "Reincarnation"
    case showbiz = "Showbiz"
    case anthropomorphic = "Anthropomorphic"
    case lovePolygon = "Love Polygon"
    case music = "Music"
    case mecha = "Mecha"
    case combatSports = "Combat Sports"
    case isekai = "Isekai"
    case gagHumor = "Gag Humor"
    case crossdressing = "Crossdressing"
    case reverseHarem = "Reverse Harem"
    case martialArts = "Martial Arts"
    case visualArts = "Visual Arts"
    case harem = "Harem"
    case otakuCulture = "Otaku Culture"
    case timeTravel = "Time Travel"
    case videoGame = "Video Game"
    case strategyGame = "Strategy Game"
    case vampire = "Vampire"
    case mahouShoujo = "Mahou Shoujo"
    case highStakesGame = "High Stakes Game"
    case cgdct = "CGDCT"
    case organizedCrime = "Organized Crime"
    case detective = "Detective"
    case performingArts = "Performing Arts"
    case medical = "Medical"
    case space = "Space"
    case memoir = "Memoir"
    case villainess = "Villainess"
    case racing = "Racing"
    case pets = "Pets"
    case magicalSexShift = "Magical Sex Shift"
    case educational = "Educational"
    case idolsFemale = "Idols (Female)"
    case idolsMale = "Idols (Male)"
}

enum Genre: String, CaseIterable, Codable, Identifiable {
    var id: Self { self }
    case action = "Action"
    case adventure = "Adventure"
    case awardWinning = "Award Winning"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case supernatural = "Supernatural"
    case mystery = "Mystery"
    case sliceOfLife = "Slice of Life"
    case comedy = "Comedy"
    case sciFi = "Sci-Fi"
    case suspense = "Suspense"
    case sports = "Sports"
    case ecchi = "Ecchi"
    case romance = "Romance"
    case girlsLove = "Girls Love"
    case boysLove = "Boys Love"
    case gourmet = "Gourmet"
    case erotica = "Erotica"
    case hentai = "Hentai"
    case avantGarde = "Avant Garde"
}

enum Role: String, Codable {
    case art = "Art"
    case storyArt = "Story & Art"
    case story = "Story"
}

enum MangaStatus: String, Codable {
    case currentlyPublishing = "currently_publishing"
    case finished = "finished"
    case onHiatus = "on_hiatus"
    case discontinued = "discontinued"
    
    var capitalizedValue: String {
        rawValue.capitalized.replacingOccurrences(of: "_", with: " ")
    }
}

enum Demography: String, CaseIterable, Codable, Identifiable {
    var id: Self { self }
    
    case Seinen
    case Shounen
    case Shoujo
    case Josei
    case Kids
    
}
