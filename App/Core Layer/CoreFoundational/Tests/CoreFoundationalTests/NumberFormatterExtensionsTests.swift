import XCTest
@testable import CoreFoundationalFoundational

final class NumberFormatterExtensionsTests: XCTestCase {
    func test_currrencyFormatter() {
        setLocale(to: .uk)
        let number0 = 8050.2102
        
        XCTAssertEqual(number0.currency, "£8,050.21")
        XCTAssertEqual(number0.currencyUS, "$8,050.21")
        XCTAssertEqual(number0.currencyUK, "£8,050.21")
    }
}

extension NumberFormatterExtensionsTests {
    private func setLocale(to locale: Locale = .uk) {
        UserDefaults.standard.set(
            [locale.language.languageCode?.identifier],
            forKey: "AppleLanguages"
        )
        UserDefaults.standard.synchronize()
    }
}
