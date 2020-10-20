//
//  Encodable+Data.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

extension Encodable {
    var data: Data? {
        let data = try? encoder.encode(self)
        return data
    }
}

private extension Encodable {
    var encoder: JSONEncoder {
        return JSONEncoder()
    }
}
