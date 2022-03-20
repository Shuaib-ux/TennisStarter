

import Foundation
class PersistenceManager{
    static let shared = PersistenceManager()
    private init(){
        
    }
    func filelocation()->URL{
        let fileloc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(fileloc[0])
        return fileloc[0]
    }
    func save(history:History){
        let file_location = filelocation().appendingPathComponent("history.plist")
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        let encoded = try! plistEncoder.encode(history)
        try! encoded.write(to: file_location)
    }
    func load()->History?{
        let fileloc = filelocation().appendingPathComponent("history.plist")
        let plistDecoder = PropertyListDecoder()
        if let data = try?Data(contentsOf: fileloc){
            let decoded = try!plistDecoder.decode(
                History.self,
                from: data)
            return decoded
        }
        return nil
    }
}
