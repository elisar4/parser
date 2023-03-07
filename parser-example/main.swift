//  main.swift
//  Created by Vladimir Roganov on 06.03.2023.

import Foundation

let root = "paste here path to root folder of this project!"
// e.g. /Users/xyz/Downloads/parser-exmaple

let loader = FileLoader(path: root + "/parser-example/FileLoader.swift",
                        tag: "Some Tag")
let declarations = try loader.collect()
print(declarations.map { $0.description }.joined(separator: "\n"))
