//
//  GroupsViewModel.swift
//  swiftUiVkApp
//
//  Created by Ivan Konishchev on 13.11.2022.
//

import Foundation
import Combine


final class GroupsViewModel: ObservableObject {
    
    private var loadSerivce: LoadServiceInterface = LoadFromInternet()
    @Published var groups: [ItemsGroup] = []
    private var subscriber = Set<AnyCancellable>()
    
    func loadGroups(token: String, userId: String) async {
        await loadSerivce.load(for: UserGroupModel.self, apiMethod: .getGroups(token: token, userId: userId))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            } receiveValue: { userGroup in
                DispatchQueue.main.async {
                    self.groups = userGroup.response.items
                    
                }
            }
            .store(in: &subscriber)
    }
}
