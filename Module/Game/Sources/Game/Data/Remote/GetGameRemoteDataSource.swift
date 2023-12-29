//
//  GetGameRemoteDataSource.swift
//  
//
//  Created by Muhamad Fardan Wardhana on 03/08/23.
//

import Foundation
import Core
import Alamofire
import Combine

public struct GetGameRemoteDataSource: DataSource {
  public typealias Request = Any
  public typealias Response = GameResponse
  
  private let _endpoint: String
  private let _parameters: [String: Any]
  
  public init(endpoint: String, parameters: [String: Any]) {
    _endpoint = endpoint
    _parameters = parameters
  }
  
  public func execute(request: Request?) -> AnyPublisher<GameResponse, Error> {
    return Future<GameResponse, Error> { completion in
      if let url = URL(string: _endpoint + "/\(request as? String ?? "")") {
        AF
          .request(
            url,
            method: .get,
            parameters: _parameters,
            encoding: URLEncoding.queryString
          )
          .validate()
          .responseDecodable(of: GameResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
