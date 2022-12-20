import Foundation
import Combine

//AnyPublisher это комбайновская обертка чтобы реактивно обрабатывать запросы с бэка

protocol ApiClientProtocol {
    func getCharacters() -> AnyPublisher<CharacterResponse, Error>
}

// Прописывает путь к конкретному файлу который хранится на бэке
private func getPath(for method: String) -> String {
    return "/api/\(method)"
}

extension ApiClient: ApiClientProtocol {
    
//MARK: GET methods
    
    func getCharacters() -> AnyPublisher<CharacterResponse, Error> {
        let request = requestBuilder.requestBuild(
            path: getPath(for: "character"),
            urlParametrs: [:])
        return performRequest(request)
    }
}
