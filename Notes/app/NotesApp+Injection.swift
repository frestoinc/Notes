//
//  NotesApp+Injection.swift
//  Notes
//
//  Created by r00t on 21/3/21.
//

import Foundation
import Resolver

extension Resolver : ResolverRegistering {
    public static func registerAllServices() {
        register{Repository()}
    }
}

