//
//  TableDataSource.swift
//  Ampersand Example
//
//  Created by Stephen Anthony on 18/10/2019.
//  Copyright © 2019 Darjeeling Apps. All rights reserved.
//

import UIKit
import Ampersand

/// Supplies the example table view with its data and styling information.
final class TableDataSource {
    
    /// The different sources from which fonts may be derived.
    ///
    /// `.system` uses
    /// the operating system's built in fonts via the
    /// `+[UIFont preferredFontForTextStyle:]` API.
    ///
    /// `application` uses Ampersand's "application font" via the
    /// `+[UIFont applicationFontForTextStyle:]` API.
    enum FontSource {
        case system
        case application
    }
    
    /// The source that the receiver will use to derive fonts.
    var fontSource: FontSource = .system
    
    /// The number of table sections represented by the receiver.
    var numberOfSections: Int {
        return sections.count
    }
    
    /// The internal sections used to represent fonts created using text styles
    /// and fonts created using point sizes and weights.
    private let sections: [FontExampleSection] = {
        var textStyleExamples = [
            TextStyleExample(textStyle: .title1, name: ".title1"),
            TextStyleExample(textStyle: .title2, name: ".title2"),
            TextStyleExample(textStyle: .title3, name: ".title3"),
            TextStyleExample(textStyle: .headline, name: ".headline"),
            TextStyleExample(textStyle: .subheadline, name: ".subheadline"),
            TextStyleExample(textStyle: .body, name: ".body"),
            TextStyleExample(textStyle: .callout, name: ".callout"),
            TextStyleExample(textStyle: .footnote, name: ".footnote"),
            TextStyleExample(textStyle: .caption1, name: ".caption1"),
            TextStyleExample(textStyle: .caption2, name: ".caption2")
        ]
        if #available(iOS 11.0, *) {
            textStyleExamples.insert(TextStyleExample(textStyle: .largeTitle, name: ".largeTitle"), at: 0)
        }
        let fontWeightExamples = [
            FontWeightExample(weight: .ultraLight, name: ".ultraLight"),
            FontWeightExample(weight: .thin, name: ".thin"),
            FontWeightExample(weight: .light, name: ".light"),
            FontWeightExample(weight: .regular, name: ".regular"),
            FontWeightExample(weight: .medium, name: ".medium"),
            FontWeightExample(weight: .semibold, name: ".semibold"),
            FontWeightExample(weight: .bold, name: ".bold"),
            FontWeightExample(weight: .heavy, name: ".heavy"),
            FontWeightExample(weight: .black, name: ".black")
        ]
        return [FontExampleSection(name: "Text Styles", examples: textStyleExamples), FontExampleSection(name: "Font Weights", examples: fontWeightExamples)]
    }()
    
    /// - Parameter section: The index of the section whose title we wish to
    /// access.
    /// - Returns The title of the section at the given index.
    func title(forSection section: Int) -> String {
        return sections[section].name
    }
    
    /// - Parameter section: The index of the section we wish to retrieve the
    /// number of examples for.
    /// - Returns The number of examples in the section at the given index.
    func numberOfExamples(inSection section: Int) -> Int {
        return sections[section].examples.count
    }
    
    /// - Parameter indexPath: The index path of the example that we wish to
    /// retrieve the name of.
    /// - Returns The name of the example at the given index path.
    func nameForExample(at indexPath: IndexPath) -> String {
        return fontExample(at: indexPath).name
    }
    
    /// - Parameter indexPath: The index path of the example that we wish to
    /// retrieve the font for.
    /// - Returns The font for the example at the given index path.
    func fontForExample(at indexPath: IndexPath) -> UIFont {
        return fontExample(at: indexPath).font(forSource: fontSource)
    }
    
    private func fontExample(at indexPath: IndexPath) -> ExampleFontSupplying {
        return sections[indexPath.section].examples[indexPath.row]
    }
}

private struct FontExampleSection {
    let name: String
    let examples: [ExampleFontSupplying]
}

protocol ExampleFontSupplying {
    var name: String { get }
    func font(forSource fontSource: TableDataSource.FontSource) -> UIFont
}

private struct TextStyleExample: ExampleFontSupplying {
    let textStyle: UIFont.TextStyle
    let name: String
    
    func font(forSource fontSource: TableDataSource.FontSource) -> UIFont {
        switch fontSource {
        case .system:
            return UIFont.preferredFont(forTextStyle: textStyle)
        case .application:
            return UIFont.applicationFont(forTextStyle: textStyle)
        }
    }
}

private struct FontWeightExample: ExampleFontSupplying {
    let weight: UIFont.Weight
    let name: String
    
    func font(forSource fontSource: TableDataSource.FontSource) -> UIFont {
        switch fontSource {
        case .system:
            return .systemFont(ofSize: 20, weight: weight)
        case .application:
            return .applicationFont(ofSize: 20, weight: weight)
        }
    }
}
