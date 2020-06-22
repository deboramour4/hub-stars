//
//  EndpointTests.swift
//  HubStarsTests
//
//  Created by Debora Moura on 21/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

import Nimble
import Quick
@testable import HubStars

class EndpointTests: QuickSpec {

    var sut: Endpoint!

    override func spec() {
        
        describe("endpoint tests") {
            
            context("repos case") {
                
                beforeEach {
                    self.sut = Endpoint.repos(perPage: 3, page: 10)
                }
                
                afterEach {
                    self.sut = nil
                }
                
                it("has correct url") {                expect(self.sut.url).to(equal("https://api.github.com/search/repositories"))
                }
                
                it("has correct method") {
                    expect(self.sut.method).to(equal(HTTPInfo.Method.get))
                }
                
                it("has correct headers") {
                    expect(self.sut.headers).to(equal([.contentType]))
                }
                        
                it("has correct path") {
                    expect(self.sut.path).to(equal("/search/repositories"))
                }
                
                it("has correct parameters") {
                    expect(self.sut.parameters["q"]).notTo(beNil())
                    expect(self.sut.parameters["sort"]).notTo(beNil())
                    expect(self.sut.parameters["page"]).notTo(beNil())
                    expect(self.sut.parameters["per_page"]).notTo(beNil())
                }
                it("has correct request") {
                    expect(self.sut.asRequest).notTo(beNil())
                }
            }
            
            context("image case") {
                
                beforeEach {
                    self.sut = Endpoint.image(url: "url")
                }
                
                afterEach {
                    self.sut = nil
                }
                            
                it("has correct url") {
                    expect(self.sut.url).to(equal("url"))
                }
                
                it("has correct method") {
                    expect(self.sut.method).to(equal(HTTPInfo.Method.get))
                }
                
                it("has correct headers") {
                    expect(self.sut.headers).to(equal([.contentType]))
                }
                
                it("has correct path") {
                    expect(self.sut.path).to(equal(""))
                }
                
                it("has correct parameters") {
                    expect(self.sut.parameters.count).to(equal(0))
                }
                it("has correct request") {
                    expect(self.sut.asRequest).notTo(beNil())
                }
            }
        }
    }
}
