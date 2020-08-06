//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
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
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `Keys.plist`.
    static let keysPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "Keys", pathExtension: "plist")

    /// `bundle.url(forResource: "Keys", withExtension: "plist")`
    static func keysPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.keysPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.id` struct is generated, and contains static references to accessibility identifiers.
  struct id {
    struct main {
      /// Accessibility identifier `backButton`.
      static let backButton: String = "backButton"
      /// Accessibility identifier `characterCollection`.
      static let characterCollection: String = "characterCollection"
      /// Accessibility identifier `heartButton`.
      static let heartButton: String = "heartButton"

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 5 images.
  struct image {
    /// Image `heart_filled`.
    static let heart_filled = Rswift.ImageResource(bundle: R.hostingBundle, name: "heart_filled")
    /// Image `heart_outline`.
    static let heart_outline = Rswift.ImageResource(bundle: R.hostingBundle, name: "heart_outline")
    /// Image `icon_back`.
    static let icon_back = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_back")
    /// Image `marvel`.
    static let marvel = Rswift.ImageResource(bundle: R.hostingBundle, name: "marvel")
    /// Image `thanos`.
    static let thanos = Rswift.ImageResource(bundle: R.hostingBundle, name: "thanos")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "heart_filled", bundle: ..., traitCollection: ...)`
    static func heart_filled(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.heart_filled, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "heart_outline", bundle: ..., traitCollection: ...)`
    static func heart_outline(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.heart_outline, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icon_back", bundle: ..., traitCollection: ...)`
    static func icon_back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_back, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "marvel", bundle: ..., traitCollection: ...)`
    static func marvel(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.marvel, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "thanos", bundle: ..., traitCollection: ...)`
    static func thanos(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.thanos, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `CharacterCell`.
    static let characterCell: Rswift.ReuseIdentifier<CharacterCollectionCell> = Rswift.ReuseIdentifier(identifier: "CharacterCell")
    /// Reuse identifier `ComicBookCell`.
    static let comicBookCell: Rswift.ReuseIdentifier<ComicBookCollectionCell> = Rswift.ReuseIdentifier(identifier: "ComicBookCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 7 localization keys.
    struct localizable {
      /// en translation: Cancel
      ///
      /// Locales: en, pt-BR
      static let cancel = Rswift.StringResource(key: "cancel", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "pt-BR"], comment: nil)
      /// en translation: Characters
      ///
      /// Locales: en, pt-BR
      static let characters = Rswift.StringResource(key: "characters", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "pt-BR"], comment: nil)
      /// en translation: Comics
      ///
      /// Locales: en, pt-BR
      static let comics = Rswift.StringResource(key: "comics", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "pt-BR"], comment: nil)
      /// en translation: Favorites
      ///
      /// Locales: en, pt-BR
      static let favorites = Rswift.StringResource(key: "favorites", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "pt-BR"], comment: nil)
      /// en translation: Oops, an error has occurred!
      ///
      /// Locales: en, pt-BR
      static let errorTitle = Rswift.StringResource(key: "errorTitle", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "pt-BR"], comment: nil)
      /// en translation: Search
      ///
      /// Locales: en, pt-BR
      static let search = Rswift.StringResource(key: "search", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "pt-BR"], comment: nil)
      /// en translation: Sorry, something went wrong. Try again later.
      ///
      /// Locales: en, pt-BR
      static let errorDescription = Rswift.StringResource(key: "errorDescription", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "pt-BR"], comment: nil)

      /// en translation: Cancel
      ///
      /// Locales: en, pt-BR
      static func cancel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("cancel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "cancel"
        }

        return NSLocalizedString("cancel", bundle: bundle, comment: "")
      }

      /// en translation: Characters
      ///
      /// Locales: en, pt-BR
      static func characters(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("characters", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "characters"
        }

        return NSLocalizedString("characters", bundle: bundle, comment: "")
      }

      /// en translation: Comics
      ///
      /// Locales: en, pt-BR
      static func comics(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("comics", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "comics"
        }

        return NSLocalizedString("comics", bundle: bundle, comment: "")
      }

      /// en translation: Favorites
      ///
      /// Locales: en, pt-BR
      static func favorites(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("favorites", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "favorites"
        }

        return NSLocalizedString("favorites", bundle: bundle, comment: "")
      }

      /// en translation: Oops, an error has occurred!
      ///
      /// Locales: en, pt-BR
      static func errorTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("errorTitle", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "errorTitle"
        }

        return NSLocalizedString("errorTitle", bundle: bundle, comment: "")
      }

      /// en translation: Search
      ///
      /// Locales: en, pt-BR
      static func search(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("search", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "search"
        }

        return NSLocalizedString("search", bundle: bundle, comment: "")
      }

      /// en translation: Sorry, something went wrong. Try again later.
      ///
      /// Locales: en, pt-BR
      static func errorDescription(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("errorDescription", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "errorDescription"
        }

        return NSLocalizedString("errorDescription", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

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
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "marvel", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'marvel' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = CharacterListViewController

      let bundle = R.hostingBundle
      let characterDetails = StoryboardViewControllerResource<CharacterDetailsViewController>(identifier: "CharacterDetails")
      let characterList = StoryboardViewControllerResource<CharacterListViewController>(identifier: "CharacterList")
      let name = "Main"

      func characterDetails(_: Void = ()) -> CharacterDetailsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: characterDetails)
      }

      func characterList(_: Void = ()) -> CharacterListViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: characterList)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "icon_back", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icon_back' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "thanos", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'thanos' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().characterDetails() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'characterDetails' could not be loaded from storyboard 'Main' as 'CharacterDetailsViewController'.") }
        if _R.storyboard.main().characterList() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'characterList' could not be loaded from storyboard 'Main' as 'CharacterListViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
