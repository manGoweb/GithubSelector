//
//  GenericResult.swift
//  Pods
//
//  Created by Ondrej Rafaj on 22/08/2017.
//
//

import Foundation


enum GenericResult<T> {
    case success(T)
    case failure(Error)
}
