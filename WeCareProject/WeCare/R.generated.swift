//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import SideMenu
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 6 storyboards.
  struct storyboard {
    /// Storyboard `Dashboard`.
    static let dashboard = _R.storyboard.dashboard()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Login`.
    static let login = _R.storyboard.login()
    /// Storyboard `News`.
    static let news = _R.storyboard.news()
    /// Storyboard `SideMenu`.
    static let sideMenu = _R.storyboard.sideMenu()
    /// Storyboard `User`.
    static let user = _R.storyboard.user()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Dashboard", bundle: ...)`
    static func dashboard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.dashboard)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Login", bundle: ...)`
    static func login(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.login)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "News", bundle: ...)`
    static func news(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.news)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "SideMenu", bundle: ...)`
    static func sideMenu(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.sideMenu)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "User", bundle: ...)`
    static func user(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.user)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 4 colors.
  struct color {
    /// Color `grayNew`.
    static let grayNew = Rswift.ColorResource(bundle: R.hostingBundle, name: "grayNew")
    /// Color `lightGreen`.
    static let lightGreen = Rswift.ColorResource(bundle: R.hostingBundle, name: "lightGreen")
    /// Color `saffron`.
    static let saffron = Rswift.ColorResource(bundle: R.hostingBundle, name: "saffron")
    /// Color `steelBlue`.
    static let steelBlue = Rswift.ColorResource(bundle: R.hostingBundle, name: "steelBlue")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "grayNew", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func grayNew(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.grayNew, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lightGreen", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lightGreen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lightGreen, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "saffron", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func saffron(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.saffron, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "steelBlue", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func steelBlue(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.steelBlue, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 18 images.
  struct image {
    /// Image `downloadnature`.
    static let downloadnature = Rswift.ImageResource(bundle: R.hostingBundle, name: "downloadnature")
    /// Image `home_logo`.
    static let home_logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "home_logo")
    /// Image `icn_Link_news`.
    static let icn_Link_news = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_Link_news")
    /// Image `icn_arrow`.
    static let icn_arrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_arrow")
    /// Image `icn_backarrow`.
    static let icn_backarrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_backarrow")
    /// Image `icn_downarrow`.
    static let icn_downarrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_downarrow")
    /// Image `icn_link_event`.
    static let icn_link_event = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_link_event")
    /// Image `icn_link_inquiries`.
    static let icn_link_inquiries = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_link_inquiries")
    /// Image `icn_link_whoiswho`.
    static let icn_link_whoiswho = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_link_whoiswho")
    /// Image `icn_linkarrow`.
    static let icn_linkarrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_linkarrow")
    /// Image `icn_menu_event`.
    static let icn_menu_event = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_menu_event")
    /// Image `icn_menu_inquiries`.
    static let icn_menu_inquiries = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_menu_inquiries")
    /// Image `icn_menu_news`.
    static let icn_menu_news = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_menu_news")
    /// Image `icn_menu_whoiswho`.
    static let icn_menu_whoiswho = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_menu_whoiswho")
    /// Image `icn_menu`.
    static let icn_menu = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_menu")
    /// Image `icn_uparrow`.
    static let icn_uparrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "icn_uparrow")
    /// Image `login_logo`.
    static let login_logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_logo")
    /// Image `side_menu`.
    static let side_menu = Rswift.ImageResource(bundle: R.hostingBundle, name: "side_menu")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "downloadnature", bundle: ..., traitCollection: ...)`
    static func downloadnature(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.downloadnature, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "home_logo", bundle: ..., traitCollection: ...)`
    static func home_logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home_logo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_Link_news", bundle: ..., traitCollection: ...)`
    static func icn_Link_news(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_Link_news, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_arrow", bundle: ..., traitCollection: ...)`
    static func icn_arrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_arrow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_backarrow", bundle: ..., traitCollection: ...)`
    static func icn_backarrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_backarrow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_downarrow", bundle: ..., traitCollection: ...)`
    static func icn_downarrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_downarrow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_link_event", bundle: ..., traitCollection: ...)`
    static func icn_link_event(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_link_event, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_link_inquiries", bundle: ..., traitCollection: ...)`
    static func icn_link_inquiries(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_link_inquiries, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_link_whoiswho", bundle: ..., traitCollection: ...)`
    static func icn_link_whoiswho(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_link_whoiswho, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_linkarrow", bundle: ..., traitCollection: ...)`
    static func icn_linkarrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_linkarrow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_menu", bundle: ..., traitCollection: ...)`
    static func icn_menu(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_menu, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_menu_event", bundle: ..., traitCollection: ...)`
    static func icn_menu_event(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_menu_event, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_menu_inquiries", bundle: ..., traitCollection: ...)`
    static func icn_menu_inquiries(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_menu_inquiries, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_menu_news", bundle: ..., traitCollection: ...)`
    static func icn_menu_news(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_menu_news, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_menu_whoiswho", bundle: ..., traitCollection: ...)`
    static func icn_menu_whoiswho(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_menu_whoiswho, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icn_uparrow", bundle: ..., traitCollection: ...)`
    static func icn_uparrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icn_uparrow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "login_logo", bundle: ..., traitCollection: ...)`
    static func login_logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_logo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "side_menu", bundle: ..., traitCollection: ...)`
    static func side_menu(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.side_menu, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 5 nibs.
  struct nib {
    /// Nib `NewsSectionHeaderView`.
    static let newsSectionHeaderView = _R.nib._NewsSectionHeaderView()
    /// Nib `SideMenuSectionHeader`.
    static let sideMenuSectionHeader = _R.nib._SideMenuSectionHeader()
    /// Nib `SideMenuTableViewCell`.
    static let sideMenuTableViewCell = _R.nib._SideMenuTableViewCell()
    /// Nib `SubCategoryTableViewCell`.
    static let subCategoryTableViewCell = _R.nib._SubCategoryTableViewCell()
    /// Nib `SubCategoryView`.
    static let subCategoryView = _R.nib._SubCategoryView()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "NewsSectionHeaderView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.newsSectionHeaderView) instead")
    static func newsSectionHeaderView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.newsSectionHeaderView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SideMenuSectionHeader", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.sideMenuSectionHeader) instead")
    static func sideMenuSectionHeader(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sideMenuSectionHeader)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SideMenuTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.sideMenuTableViewCell) instead")
    static func sideMenuTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sideMenuTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SubCategoryTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.subCategoryTableViewCell) instead")
    static func subCategoryTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.subCategoryTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SubCategoryView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.subCategoryView) instead")
    static func subCategoryView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.subCategoryView)
    }
    #endif

    static func newsSectionHeaderView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsSectionHeaderView? {
      return R.nib.newsSectionHeaderView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsSectionHeaderView
    }

    static func sideMenuSectionHeader(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SideMenuSectionHeader? {
      return R.nib.sideMenuSectionHeader.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SideMenuSectionHeader
    }

    static func sideMenuTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SideMenuTableViewCell? {
      return R.nib.sideMenuTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SideMenuTableViewCell
    }

    static func subCategoryTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SubCategoryTableViewCell? {
      return R.nib.subCategoryTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SubCategoryTableViewCell
    }

    static func subCategoryView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SubCategoryView? {
      return R.nib.subCategoryView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SubCategoryView
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 5 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `DashboardTableViewCell`.
    static let dashboardTableViewCell: Rswift.ReuseIdentifier<DashboardTableViewCell> = Rswift.ReuseIdentifier(identifier: "DashboardTableViewCell")
    /// Reuse identifier `NewsEventSurveyTableViewCell`.
    static let newsEventSurveyTableViewCell: Rswift.ReuseIdentifier<NewsEventSurveyTableViewCell> = Rswift.ReuseIdentifier(identifier: "NewsEventSurveyTableViewCell")
    /// Reuse identifier `SideMenuTableViewCell`.
    static let sideMenuTableViewCell: Rswift.ReuseIdentifier<SideMenuTableViewCell> = Rswift.ReuseIdentifier(identifier: "SideMenuTableViewCell")
    /// Reuse identifier `SubCategoryTableViewCell`.
    static let subCategoryTableViewCell: Rswift.ReuseIdentifier<SubCategoryTableViewCell> = Rswift.ReuseIdentifier(identifier: "SubCategoryTableViewCell")
    /// Reuse identifier `UserTableViewCell`.
    static let userTableViewCell: Rswift.ReuseIdentifier<UserTableViewCell> = Rswift.ReuseIdentifier(identifier: "UserTableViewCell")

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _SideMenuSectionHeader.validate()
      try _SideMenuTableViewCell.validate()
    }

    struct _NewsSectionHeaderView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "NewsSectionHeaderView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsSectionHeaderView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsSectionHeaderView
      }

      fileprivate init() {}
    }

    struct _SideMenuSectionHeader: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "SideMenuSectionHeader"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SideMenuSectionHeader? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SideMenuSectionHeader
      }

      static func validate() throws {
        if UIKit.UIImage(named: "icn_downarrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_downarrow' is used in nib 'SideMenuSectionHeader', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu_news", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu_news' is used in nib 'SideMenuSectionHeader', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "grayNew", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'grayNew' is used in storyboard 'SideMenuSectionHeader', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }

    struct _SideMenuTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = SideMenuTableViewCell

      let bundle = R.hostingBundle
      let identifier = "SideMenuTableViewCell"
      let name = "SideMenuTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SideMenuTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SideMenuTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "icn_downarrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_downarrow' is used in nib 'SideMenuTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "lightGreen", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'lightGreen' is used in storyboard 'SideMenuTableViewCell', but couldn't be loaded.") }
        }
      }

      fileprivate init() {}
    }

    struct _SubCategoryTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = SubCategoryTableViewCell

      let bundle = R.hostingBundle
      let identifier = "SubCategoryTableViewCell"
      let name = "SubCategoryTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SubCategoryTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SubCategoryTableViewCell
      }

      fileprivate init() {}
    }

    struct _SubCategoryView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SubCategoryView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SubCategoryView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SubCategoryView
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try dashboard.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try login.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try news.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try sideMenu.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try user.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct dashboard: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let dashboardVC = StoryboardViewControllerResource<DashboardVC>(identifier: "DashboardVC")
      let name = "Dashboard"

      func dashboardVC(_: Void = ()) -> DashboardVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: dashboardVC)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "icn_arrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_arrow' is used in storyboard 'Dashboard', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu_event", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu_event' is used in storyboard 'Dashboard', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu_inquiries", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu_inquiries' is used in storyboard 'Dashboard', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu_news", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu_news' is used in storyboard 'Dashboard', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu_whoiswho", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu_whoiswho' is used in storyboard 'Dashboard', but couldn't be loaded.") }
        if UIKit.UIImage(named: "login_logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'login_logo' is used in storyboard 'Dashboard', but couldn't be loaded.") }
        if UIKit.UIImage(named: "side_menu", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'side_menu' is used in storyboard 'Dashboard', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "grayNew", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'grayNew' is used in storyboard 'Dashboard', but couldn't be loaded.") }
          if UIKit.UIColor(named: "lightGreen", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'lightGreen' is used in storyboard 'Dashboard', but couldn't be loaded.") }
          if UIKit.UIColor(named: "saffron", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'saffron' is used in storyboard 'Dashboard', but couldn't be loaded.") }
          if UIKit.UIColor(named: "steelBlue", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'steelBlue' is used in storyboard 'Dashboard', but couldn't be loaded.") }
        }
        if _R.storyboard.dashboard().dashboardVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'dashboardVC' could not be loaded from storyboard 'Dashboard' as 'DashboardVC'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "login_logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'login_logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct login: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let loginVC = StoryboardViewControllerResource<LoginVC>(identifier: "LoginVC")
      let name = "Login"

      func loginVC(_: Void = ()) -> LoginVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: loginVC)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "login_logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'login_logo' is used in storyboard 'Login', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.login().loginVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'loginVC' could not be loaded from storyboard 'Login' as 'LoginVC'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct news: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let eventDetailVC = StoryboardViewControllerResource<EventDetailVC>(identifier: "EventDetailVC")
      let name = "News"
      let newsDetailVC = StoryboardViewControllerResource<NewsDetailVC>(identifier: "NewsDetailVC")
      let newsEventSurveyVC = StoryboardViewControllerResource<NewsEventSurveyVC>(identifier: "NewsEventSurveyVC")

      func eventDetailVC(_: Void = ()) -> EventDetailVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: eventDetailVC)
      }

      func newsDetailVC(_: Void = ()) -> NewsDetailVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newsDetailVC)
      }

      func newsEventSurveyVC(_: Void = ()) -> NewsEventSurveyVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newsEventSurveyVC)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "icn_arrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_arrow' is used in storyboard 'News', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_backarrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_backarrow' is used in storyboard 'News', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_downarrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_downarrow' is used in storyboard 'News', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu' is used in storyboard 'News', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu_event", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu_event' is used in storyboard 'News', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu_news", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu_news' is used in storyboard 'News', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "lightGreen", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'lightGreen' is used in storyboard 'News', but couldn't be loaded.") }
          if UIKit.UIColor(named: "saffron", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'saffron' is used in storyboard 'News', but couldn't be loaded.") }
        }
        if _R.storyboard.news().eventDetailVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'eventDetailVC' could not be loaded from storyboard 'News' as 'EventDetailVC'.") }
        if _R.storyboard.news().newsDetailVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newsDetailVC' could not be loaded from storyboard 'News' as 'NewsDetailVC'.") }
        if _R.storyboard.news().newsEventSurveyVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newsEventSurveyVC' could not be loaded from storyboard 'News' as 'NewsEventSurveyVC'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct sideMenu: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "SideMenu"
      let sideMenuNavigationController = StoryboardViewControllerResource<SideMenu.SideMenuNavigationController>(identifier: "SideMenuNavigationController")

      func sideMenuNavigationController(_: Void = ()) -> SideMenu.SideMenuNavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: sideMenuNavigationController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "home_logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'home_logo' is used in storyboard 'SideMenu', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_downarrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_downarrow' is used in storyboard 'SideMenu', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "grayNew", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'grayNew' is used in storyboard 'SideMenu', but couldn't be loaded.") }
          if UIKit.UIColor(named: "lightGreen", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'lightGreen' is used in storyboard 'SideMenu', but couldn't be loaded.") }
          if UIKit.UIColor(named: "steelBlue", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'steelBlue' is used in storyboard 'SideMenu', but couldn't be loaded.") }
        }
        if _R.storyboard.sideMenu().sideMenuNavigationController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'sideMenuNavigationController' could not be loaded from storyboard 'SideMenu' as 'SideMenu.SideMenuNavigationController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct user: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "User"
      let userDetailVC = StoryboardViewControllerResource<UserDetailVC>(identifier: "UserDetailVC")
      let userVC = StoryboardViewControllerResource<UserVC>(identifier: "UserVC")

      func userDetailVC(_: Void = ()) -> UserDetailVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: userDetailVC)
      }

      func userVC(_: Void = ()) -> UserVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: userVC)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "icn_backarrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_backarrow' is used in storyboard 'User', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_linkarrow", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_linkarrow' is used in storyboard 'User', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu' is used in storyboard 'User', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icn_menu_whoiswho", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icn_menu_whoiswho' is used in storyboard 'User', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "grayNew", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'grayNew' is used in storyboard 'User', but couldn't be loaded.") }
        }
        if _R.storyboard.user().userDetailVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'userDetailVC' could not be loaded from storyboard 'User' as 'UserDetailVC'.") }
        if _R.storyboard.user().userVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'userVC' could not be loaded from storyboard 'User' as 'UserVC'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
