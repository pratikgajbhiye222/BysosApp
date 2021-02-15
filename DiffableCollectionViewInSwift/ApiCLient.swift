//
//  ApiCLient.swift
//  DiffableCollectionViewInSwift
//
//  Created by BYSOS 2019 on 15/02/21.
//

import Foundation

class APIClient {
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
        
        return task
    }
    
    
    //MARK:- Get Contest List for the Home Page
    class func getContestListForHomePage(completion: @escaping (ContestNewList, Bool,Error?) -> Void){
        taskForGETRequest(url: URL(string:"http://103.86.177.104:8100/bysos/contest/contestlist/1234")!, responseType: ContestNewList.self) { response, error in
            if let response = response {
                print(response)
                completion(response,true ,nil)
            } else {
                completion(response!,false , error)
            }
        }
    }
    
}
