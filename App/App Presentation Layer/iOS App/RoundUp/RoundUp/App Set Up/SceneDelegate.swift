//
//  SceneDelegate.swift
//  RoundUp
//
//  Created by TM.Dev on 11/07/2024.
//

import AccountsFeature
import CoreNetworking
import CorePresentation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var accessToken = "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21TQW7jMAz8SuFzWdSOkyi59bYf2AdQFJUItSVDktMtFvv3lS05joPeMjPkcGgqfysTQnWucDCguHdvIaLvjL1ItJ9v5PrqtQqjTBWNpvZdoAChJUOrxR7kTjfARzoKrVVLqknF_GeozvWxPRxOp3pfv1YGYyHq5jgRSORGG3-5TrH_bVTx1sQHEFLU0CrRgKQ0QMtks2v2DQtK3tF9sl07SLY1nLhOaZI_4EFLQBZymkStmjrSWh9EHMJDF2kB2AgNrZAKxPHUwDtTvT_stJbznEBu4Omj5KRwnaOCxZ7PnlG9PAnxe3gSjGIbjTbst3xnQtwwBSjlU8gzKxPvICsxIl17vleu-MubyC84xqvzJqSTgbHK3IwascvFEju0VKIRegXkbPSuy4MmpmjOauN7jMZZcBr0aFUJQGOIrl_24B5N6e7RKox8VtxxyrHAuazniAnhmRKcxAXPnQN-My9SBsUkg7UITI-X4pm19SdEjzYgTZnvNHSO0vardybATZ_hmS1d3mnTLaPy7A01V3kmNkPcgLCV8j0C3tIpAlzcmmPDlVU33OzzyOTldPrsP1is4g9eq5hN6cpq7FhBWnt9RoFjTAuOQ4EDLs8k_f_TK0qPyXn1MH7LLnO37A_94L7snY88BQAKt2dqUDpTjzedT_F85Orff3gVVtOyBAAA.x6h2KfOdB8iuTU4I0AkhfFW6i6Vi6_laDk8YOvT_1nLFRj1suYrlxL0UheIfHCVJK-CFVX9FOLzamVvtZQyCDrtduP0NPY9rN3EM2d0dBo8Spw1C4Egm1soOc0SKFn-SE0_gZ21yca2QFQOkRjnP7S2za0WAG2S8JGPslL39Xwlq7fSj5l_8EqO14rEOw0iwN7dNKWZhOZM7PxEqyGRj07o9fh5MBnLaP8zMBdNThjyqp_PmIj77Cfy1FH28W96xG6ADUvcyf4P4Kd8T78C_eK23tr3FfnJs0fDfjeQZDT_lSh4cS5hrcpb7YDI90yuLEQPFnWUkV1gG8jo2lO2EuVfhz7xh-auuPi8lhUBTWql3YjceN48nAh0SBZpm-2Lp1ZlYf2j_I9uWBVKa39FPGGjRHfiMxTQ9yHKxoeeWWfjcZwHAZeai77KyAE_ak2aPapJUwJI1sAjKmpEqkMOs2qcRnApDw0jXSvIwd4xQ7qTbhlhBPe0oWNpVoJNyI5mBrcrudFHmRP96H270Ky0ZEEseTMd3u5uevTY4f1GrHeNWb2XCMKQIRhaejBPLjYtb1PPZBJQ1pgeo6zkWJ-6eAsgu-wBmFXfipga85ARtffDlEjYpp3dAjAskK_lwmgPhsN_x6CSkoCvYWnbaoN6SwiO5mpxu0abw78K0MfM73F8"
    private var refreshToken = "NYI4YP33oAuAR8ascCXEUU9txnP0f0VOL6nRs9bIBh89v4MqdcwQupUzN6QPpq4f"
    private var clientID = "Sl5RTZJfKBAgiQ6agmBw"
    private var clientSecret = "7QOAOkaNCli9x3gH2id3eqVx2fYsfcUOz3NDmxtC"
    
    var client: HTTPClient?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession, 
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            fatalError("Window failed to initialise in SceneDelegate")
        }
        setupAuthenticationStore()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = accountsFeed()
        window?.makeKeyAndVisible()
    }

    private func accountsFeed() -> UIViewController {
        let client = URLSessionHTTPClient()
        let router = Router(navigationController: .init())
        let coordinator = AppLaunchCoordinator(
            router: router,
            client: client
        )
        coordinator.start()
        return coordinator.router.navigationController
    }
    
    private func setupAuthenticationStore() {
        let authenticationStore = UserDefaultsAuthenticationStore(accessToken: accessToken, refreshToken: refreshToken)
        let authenticationStoreManager = UserDefaultsAuthenticationStoreManager()
        authenticationStoreManager.saveStore(authenticationStorable: authenticationStore)
    }
}
