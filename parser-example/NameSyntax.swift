//  NameSyntax.swift
//  Created by Vladimir Roganov on 06.03.2023.

import SwiftSyntax

public let delim = " > "

struct Name {
    static func from(_ node: DeclSyntaxProtocol) -> String? {
        return from(node._syntaxNode)
    }

    static func from(_ node: Syntax) -> String? {
        switch node.kind {
        case .initializerDecl:
            if let ini = node.as(InitializerDeclSyntax.self)?.signature.description {
                return "i." + ini
            }
            return nil
        case .structDecl:
            if let str = node.as(StructDeclSyntax.self)?.identifier.description.trimmed {
                return "s." + str
            }
            return nil
        case .extensionDecl:
            if let ext = node.as(ExtensionDeclSyntax.self)?.extendedType.description.trimmed {
                return "+." + ext
            }
            return nil
        case .classDecl:
            if let cla = node.as(ClassDeclSyntax.self)?.identifier.description.trimmed {
                return "c." + cla
            }
            return nil
        case .enumDecl:
            if let enu = node.as(EnumDeclSyntax.self)?.identifier.description.trimmed {
                return "e." + enu
            }
            return nil
        case .protocolDecl:
            if let pro = node.as(ProtocolDeclSyntax.self)?.identifier.description.trimmed {
                return "p." + pro
            }
            return nil
        case .functionDecl:
            if let fun = node.as(FunctionDeclSyntax.self)?.identifier.description.trimmed {
                return "f." + fun
            }
            return nil
        default: return nil
        }
    }
}

extension Syntax {
    var parentChain: [Syntax] {
        var res: [Syntax] = [self]
        var par = parent
        while par != nil {
            res.insert(par!, at: 0)
            par = par?.parent
        }
        return res
    }

    var namesChain: String {
        return parentChain
            .compactMap({ Name.from($0) })
            .joined(separator: delim)
    }
}

extension DeclSyntaxProtocol {
    var names: String {
        guard let declName = Name.from(self) else { return "" }
        if let parent {
            let chain = parent.namesChain
            if chain.count > 0 {
                return chain + delim + declName
            }
        }
        return declName
    }
}

extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
