//
//  DataFactory.swift
//  animanga_converter
//
//  Created by Om Gautam on 8/10/22.
//

import Foundation

protocol CSVLoadable {
    init?(raw: [String])
}


struct Anime: Identifiable, CSVLoadable{
    var animeEpisode: String = ""
    var mangaChapter: String = ""
    var id = UUID()
    
    init?(raw: [String]) {
        animeEpisode = raw[0]
        mangaChapter = raw[1]
    }
    

}

//func splitManga(){
//    mangaChapter.components(separatedBy: "|")
//}

extension CSVLoadable{
    static func loadCSV(from csvName: String) -> [Self] {
        var csvToStruct = [Self]()
        
        // Locating CSV file
        guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else{
            return []
        }
        
        // Convert contents into one long string
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch{
            print(error)
            return []
        }
        
        // Split the long string into an array of "rows" of data. Each row is a string
        // Detect "\n" carriage return, then split
        var rows = data.components(separatedBy: "\n")
        
        
        // Count the number of header colums before removing
        let columnCount = rows.first?.components(separatedBy: ",").count
        
        // Remove header rows
        rows.removeFirst()
        
        // Loop around each row and split into columns
        for row in rows{
            let csvColumns = row.components(separatedBy: ",")
            if csvColumns.count == columnCount {
                let genericStruct = Self.init(raw: csvColumns)
                csvToStruct.append(genericStruct!)
            }
        }
        
        return csvToStruct
        
    }
}

