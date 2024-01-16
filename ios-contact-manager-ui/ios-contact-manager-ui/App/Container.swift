//
//import Foundation
//
//final class Container {
//    
//    static let shared = Container()
//    
//    private init() {}
//    
//    private var services: [String: Any] = [:]
//    
//    func bind<Service>(service: Service.Type, resolver: @escaping (Container) -> Service) {
//        let key = String(describing: Service.self)
//        self.services[key] = resolver(self)
//    }
//    
//    func resolve<Service>(_ type: Service.Type) -> Service {
//        let key = String(describing: Service.self)
//        guard let service = services[key] as? Service else {
//            fatalError("주입할 객체가 service 딕셔너리에 바인딩되어있지 않음!")
//        }
//        return service
//    }
//}
