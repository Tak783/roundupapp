//
//  URLPool.swift
//  CoreNetworking
//
//  Created by TM.Dev on 10/04/2021.
//

import Foundation

public struct URLPool {
    public static func configureURL(
        scheme: String,
        host: String,
        path: String,
        parameters: [URLQueryItem]? = nil
    ) -> URL {
        let urlComponents = configureURLComponents(
            scheme: scheme,
            host: host,
            path: path,
            parameters: parameters
        )
        guard 
            let url = urlComponents.url,
            let urlString = url.absoluteString.removingPercentEncoding,
            let fullURL = URL(string: urlString) else
        {
            fatalError("URL is not correctly configured")
        }
        return fullURL
    }

    private static func configureURLComponents(
        scheme: String, 
        host: String,
        path: String,
        parameters: [URLQueryItem]?
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = parameters
        return components
    }
}
