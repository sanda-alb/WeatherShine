//
//  LocationServiceProtocol.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/15/22.
//


protocol LocationServiceProtocol: AnyObject {
    func authorizationRestricted()
    func authorizationUknown()
    func promptAuthorizationAction()
    func didAuthorize()
}

