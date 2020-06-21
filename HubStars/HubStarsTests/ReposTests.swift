//
//  ReposTests.swift
//  HubStarsTests
//
//  Created by Debora Moura on 21/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import HubStars

class ReposTests: QuickSpec {
    
    var sut: Repos!
    
    override func spec() {
        
        beforeEach {
            if let path = Bundle(for: type(of: self)).path(forResource:"repos_mock", ofType: "json") {
              do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                self.sut = try decoder.decode(Repos.self, from: data)
              } catch {
                fail("could not parse JSON")
              }
            }
        }
        
        afterEach {
            self.sut = nil
        }
        
        describe("repos codable tests") {
                
            it("has correct array count") {
                expect(self.sut.all.count).to(equal(2))
            }
            
            it("has correct incompleteResults") {
                expect(self.sut.incompleteResults).to(equal(false))
            }
            
            it("has correct totalCount") {
                expect(self.sut.totalCount).to(equal(2))
            }
                    
            it("has correct url") {
                expect(self.sut.all[0].htmlURL).to(equal("html_url1"))
                expect(self.sut.all[0].id).to(equal(0))
                expect(self.sut.all[0].name).to(equal("repo-name-1"))
                expect(self.sut.all[0].stars).to(equal(38721))
                
                expect(self.sut.all[0].owner.avatarURL).to(equal("avatar_url1"))
                expect(self.sut.all[0].owner.id).to(equal(0))
                expect(self.sut.all[0].owner.login).to(equal("myname1"))
            }
        }
    }
}
