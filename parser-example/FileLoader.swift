//  FileLoader.swift
//  Created by Vladimir Roganov on 06.03.2023.

import Foundation
import SwiftSyntax
import SwiftParser

public struct FileLoader {
    let path: String
    let tag: String

    public init(path: String, tag: String) {
        self.path = path
        self.tag = tag
    }

    public func loadContents() throws -> String {
        let url = URL(filePath: path)
        return try String(contentsOf: url)
    }

    public struct Decl: Equatable, CustomStringConvertible {
        let declaration: String
        let row: Int
        let col: Int
        let file: String

        public var description: String {
            return declaration + " (\(row):\(col) \(file))"
        }
    }

    public func collect() throws -> [Decl] {
        let cont: String = try loadContents()

        let sourceFile: SourceFileSyntax = Parser.parse(source: cont)
        let vis = Visitor(viewMode: .all)
        vis.walk(sourceFile)

        var decls: [Decl] = []
        for (decl, pos) in zip(vis.declarations, vis.positions) {
            let rowCol = cont.rowCol(at: pos)
            decls.append(Decl(declaration: decl, row: rowCol.0, col: rowCol.1, file: tag))
        }

        decls.sort { item1, item2 in
            return item1.declaration > item2.declaration
        }

        return decls
    }
}

extension String {
    func rowCol(at: Int) -> (Int, Int) {
        let to = self.utf8.index(self.utf8.startIndex, offsetBy: at)
        let from = self.utf8.startIndex
        let subb = self.utf8[from...to]
        guard let str = String(subb) else { return (0, 0) }
        let lines = str.components(separatedBy: "\n")
        return (lines.count + 1, lines.last?.count ?? 0)
    }
}
