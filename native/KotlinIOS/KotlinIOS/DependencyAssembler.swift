//
//  Assembler.swift
//  KotlinIOS
//
//  Created by Joe Birch on 26/04/2020.
//  Copyright © 2020 Joe Birch. All rights reserved.
//

import UIKit
import SwiftUI
import Authentication
import Firebase
import Backend
import Dashboard
import Swinject
import Common
import Creation

class DependencyAssembler: Assembly {
    
    func assemble(container: Container) {
        container.register(BackendProvider.self) { _ in BackendProvider() }
        .inObjectScope(.container)
        .initCompleted { resolver, screen in
            (resolver.resolve(BackendProvider.self)!).configure()
        }
        
        container.register(ScreenFactory.self) { resolver -> ScreenFactory in
            ViewProvider(
                resolver: container
            )
        }
    
        container.register(DashboardViewFactory.self) { resolver -> DashboardViewFactory in
             DashboardViewFactory(
                 backendProvider: container.resolve(BackendProvider.self)!, viewProvider: container.resolve(ScreenFactory.self)!
             )
         }
                 
         container.register(AuthenticationViewFactory.self) { resolver -> AuthenticationViewFactory in
             AuthenticationViewFactory(
                backendProvider: container.resolve(BackendProvider.self)!, viewProvider: container.resolve(ScreenFactory.self)!
             )
         }

        container.register(CreationViewFactory.self) { resolver -> CreationViewFactory in
            CreationViewFactory()
        }
    }
}
