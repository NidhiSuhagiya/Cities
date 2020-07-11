//
//  JsonServices.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation

class JsonServices {
    
    final func fetchCitiesList(completionHandler: @escaping(([CitiesModel]?, String?) ->())) {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl)// (contentsOf: fileUrl)
                let jsonObj = try JSONDecoder().decode([CitiesModel].self, from: data)

//                let temp = data.withUnsafeBytes {
//                    return $0.split(separator: UInt8(ascii: "\n")).map { String(decoding: UnsafeRawBufferPointer(rebasing: $0), as: UTF8.self) }
//                }
                completionHandler(jsonObj, nil)
            } catch {
                print("error json:- \(error)")

                print("error:- \(error.localizedDescription)")
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    static func fetchCitiesData(completionHandler: @escaping(() ->())) {

        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            let pathURL = URL(fileURLWithPath: (NSString(string:path).expandingTildeInPath))
            if FileManager.default.fileExists(atPath: pathURL.path) { print(1) }

            do {
                // Read an entire text file into an NSString.
                let contents = try NSString(contentsOfFile: path,
                    encoding: String.Encoding.ascii.rawValue)

                // Print all lines.

                contents.enumerateLines({ (line, stop) -> () in
                    print("Line = \(line)")
                })
            } catch {
                print("error:- \(error.localizedDescription)")
            }
//            let s = StreamReader(url: pathURL)
//            for _ in 1...50 {
//                if let line = s?.nextLine() {
//                    print(line)
//                }
//            }
        }
    }
}


//class StreamReader {
//    let encoding: String.Encoding
//    let chunkSize: Int
//    let fileHandle: FileHandle
//    var buffer: Data
//    let delimPattern : Data
//    var isAtEOF: Bool = false
//
//    init?(url: URL, delimeter: String = "\n", encoding: String.Encoding = .utf8, chunkSize: Int = 4096)
//    {
//        guard let fileHandle = try? FileHandle(forReadingFrom: url) else { return nil }
//        self.fileHandle = fileHandle
//        self.chunkSize = chunkSize
//        self.encoding = encoding
//        buffer = Data(capacity: chunkSize)
//        delimPattern = delimeter.data(using: .utf8)!
//    }
//
//    deinit {
//        fileHandle.closeFile()
//    }
//
//    func rewind() {
//        fileHandle.seek(toFileOffset: 0)
//        buffer.removeAll(keepingCapacity: true)
//        isAtEOF = false
//    }
//
//    func nextLine() -> String? {
//        if isAtEOF { return nil }
//
//        repeat {
//            if let range = buffer.range(of: delimPattern, options: [], in: buffer.startIndex..<buffer.endIndex) {
//                let subData = buffer.subdata(in: buffer.startIndex..<range.lowerBound)
//                let line = String(data: subData, encoding: encoding)
//                buffer.replaceSubrange(buffer.startIndex..<range.upperBound, with: [])
//                return line
//            } else {
//                let tempData = fileHandle.readData(ofLength: 50)
//                if tempData.count == 0 {
//                    isAtEOF = true
//                    return (buffer.count > 0) ? String(data: buffer, encoding: encoding) : nil
//                }
//                buffer.append(tempData)
//            }
//        } while true
//    }
//}
