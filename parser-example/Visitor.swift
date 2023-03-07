//  Visitor.swift
//  Created by Vladimir Roganov on 06.03.2023.

import Foundation
import SwiftParser
import SwiftSyntax

public class Visitor: SyntaxVisitor {
    public var positions: [Int] = []
    public var declarations: [String] = []

    public override func visit(_ node: InitializerDeclSyntax) -> SyntaxVisitorContinueKind {
        // TODO: 〠 InitializerDeclSyntax params parsing
        // _ node: FunctionSignatureSyntax -> (path: String, tag: String)
        declarations.append(node.names)
        positions.append(node.position.utf8Offset)
        return super.visit(node)
    }

    public override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        declarations.append(node.names)
        positions.append(node.position.utf8Offset)
        return super.visit(node)
    }

    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        declarations.append(node.names)
        positions.append(node.position.utf8Offset)
        return super.visit(node)
    }

    public override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        declarations.append(node.names)
        positions.append(node.position.utf8Offset)
        return super.visit(node)
    }

    public override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
        declarations.append(node.names)
        positions.append(node.position.utf8Offset)
        return super.visit(node)
    }

    public override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        declarations.append(node.names)
        positions.append(node.position.utf8Offset)
        return super.visit(node)
    }
}
