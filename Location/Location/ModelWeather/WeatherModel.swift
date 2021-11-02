//
//  WeatherModel.swift
//  Location
//
//  Created by Александр Воробей on 28.10.2021.
//

import Foundation

struct Weather: Codable {
    let fact: Fact
}

struct Fact: Codable {
    let temp: Int
    let condition: String
}
