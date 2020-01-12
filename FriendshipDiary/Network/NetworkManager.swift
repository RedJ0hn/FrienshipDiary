//
//  ViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 04/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let address = NetworkURL()
    
    static var sessionToken: String?
    
    private static var alamofireManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return Session(configuration: configuration)
    }()
    
    private static func request(_ address: Link, method: HTTPMethod, parameters: Parameters? = nil, logMethod: Bool = false, successBlock: @escaping ([String:Any]?) -> (), failtureBlock: @escaping (ApiItemError?) -> ()) {
        let headers : HTTPHeaders = [
            "Authorization": "Bearer " + (sessionToken ?? ""),
            "Content-Type": "application/json"
        ]
        alamofireManager.request(address.full, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if logMethod {
                    print("\nRequest: \(address) \nWith parametres: \(parameters ?? [:]) \nJSON response: \(json)")
                }
                successBlock(json.dictionaryObject)
                
            case .failure(_):
                var error: ApiItemError?
                if let data = response.data {
                    error = try? JSONDecoder().decode(ApiItemError.self, from: data)
                }
                failtureBlock(error)
            }
        }
    }
    
    //MARK: - Before login
    
    static func login(userName: String, password: String, successBlock: @escaping ([String:Any]?)->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        let parameters: Parameters = [
            "username" : userName,
            "password" : password
        ]
        
        request(NetworkManager.address.postLogin, method: .post, parameters: parameters, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func register(userName: String, password: String, firstName: String, lastName: String, successBlock: @escaping ([String:Any]?)->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        let parameters: Parameters = [
            "username" : userName,
            "password" : password,
            "lastname" : lastName,
            "firstname" : firstName
        ]
        
        request(NetworkManager.address.postRegister, method: .post, parameters: parameters, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    
    static func getMemories(successBlock: @escaping ([String:Any]?)->(), failtureBlock: @escaping (ApiItemError?) -> ()) {
        
        
        request(NetworkManager.address.getMemories, method: .get, successBlock: { (data) in
            successBlock(data)
        }) { (error) in
            failtureBlock(error)
        }
    }
    

    
    // MARK: - Details
    
//    func getTrainerDetails(withId ident: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = ident
//
//        return request(address.getTrainerDetails, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func addTrainerToFavourites(withId ident: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = ident
//
//        return request(address.addTrainerToFavourites, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func removeTrainerFromFavourites(withId ident: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = ident
//
//        return request(address.removeTrainerFromFavourites, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func removeTrainerFromMyTrainers(withId ident: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = ident
//
//        return request(address.removeTrainerFromMyTrainers, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getTrainerOpinions(withId ident: Int, page: Int, type: String, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = ident
//        parameters["page"] = page
//        parameters["type"] = type
//
//        return request(address.getTrainerOpinions, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getObjectDetails(objectId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["objectId"] = objectId
//
//        return request(address.getObjectDetails, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func requestVisitWithTrainer(trainerId: Int, monthDay: Int, month: Int, year: Int, hours: String, facilityId: Int? = nil, additionalMessage: String? = nil, completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        var parameters = minParams
//        parameters["trainerId"] = trainerId
//        parameters["monthDay"] = monthDay
//        parameters["month"] = month
//        parameters["year"] = year
//        parameters["hours"] = hours
//
//        if additionalMessage != nil && additionalMessage != "" {
//            parameters["additionalMessage"] = additionalMessage
//        }
//
//        if facilityId != nil {
//            parameters["facilityId"] = facilityId
//        }
//
//        return request(address.requestVisitWithTrainer, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getClientDetails(clientId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        parameters["userId"] = clientId
//
//        return request(address.getClientDetails, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func saveNotesAboutClient(clientId: Int, notes: String, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        parameters["userId"] = clientId
//        parameters["notes"] = notes
//
//        return request(address.saveNotesAboutClient, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func signInToEvent(eventId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        parameters["eventId"] = eventId
//
//        return request(address.signInToEvent, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func signOutToEvent(eventId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        parameters["eventId"] = eventId
//
//        return request(address.signOutToEvent, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getObjectEvents(objectId: Int, monthDay: Int, month: Int, year: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        parameters["objectId"] = objectId
//        parameters["monthDay"] = monthDay
//        parameters["month"] = month
//        parameters["year"] = year
//
//        return request(address.getObjectEvents, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func removeUserFromMyClients(userId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["userId"] = userId
//
//        return request(address.removeUserFromMyClients, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func setFitManagerAccess(userId: Int, accessToAll: Bool, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["userId"] = userId
//        parameters["accessToAll"] = accessToAll.hashValue
//
//        return request(address.setFitManagerAccess, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    // MARK: - Search
//
//    func searchObjects(text: String?, sortInt: Int, cityId: Int?, range: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        let parameters = getSearchParameters(text: text, sortInt: sortInt, cityId: cityId, range: range)
//
//        return request(address.searchObjects, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func searchDisciplines(text: String?, sortInt: Int, cityId: Int?, range: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        let parameters = getSearchParameters(text: text, sortInt: sortInt, cityId: cityId, range: range)
//
//        return request(address.searchDisciplines, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func searchTrainers(text: String?, sortInt: Int, cityId: Int?, range: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        let parameters = getSearchParameters(text: text, sortInt: sortInt, cityId: cityId, range: range)
//
//        return request(address.searchTrainers, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    private func getSearchParameters(text: String?, sortInt: Int, cityId: Int?, range: Int) -> Parameters {
//
//        var parameters = minParams
//        parameters["sort"] = sortInt
//
//        if text != nil {
//            parameters["text"] = text
//        }
//
//        if let cityId = cityId {
//            parameters["cityId"] = cityId
//            parameters["range"] = range
//        }
//
//        return parameters
//    }
//
//    func getTrainersOfObject(objectId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["objectId"] = objectId
//
//        return request(address.getTrainersOfObject, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getTrainersOfDiscipline(disciplineId: Int, cityId: Int?, range: Int?, completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        var parameters = minParams
//        parameters["disciplineId"] = disciplineId
//
//        if let cityId = cityId, let range = range {
//            parameters["cityId"] = cityId
//            parameters["range"] = range
//        }
//
//        return request(address.getTrainersOfDiscipline, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Visit history
//
//    func getMyVisits(page: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["page"] = page
//
//        return request(address.getMyVisits, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getMyVisit(visitId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["page"] = 1
//        parameters["visitId"] = visitId
//
//        return request(address.getMyVisits, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func changeVisitDate(visitId: Int, monthDay: Int, month: Int, year: Int, hourFrom: String, hourTo: String, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["visitId"] = visitId
//        parameters["monthDay"] = monthDay
//        parameters["month"] = month
//        parameters["year"] = year
//        parameters["hours"] = hourFrom + " - " + hourTo
//
//        return request(address.changeVisitDate, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func cancelVisit(withVisitId visitId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["visitId"] = visitId
//
//        return request(address.cancelVisit, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func acceptVisit(withVisitId visitId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["visitId"] = visitId
//
//        return request(address.acceptVisit, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func refuseInvitation(trainerId : Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = trainerId
//
//        return request(address.refuseInvitation, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func confirmInvitation(trainerId : Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = trainerId
//
//        return request(address.confirmInvitation, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Profile
//
//    func getUserProfile(completionBlock: @escaping completionBlock) -> NetworkRequest {
//        return request(address.getUserProfile, method: .post, parameters: minParams, completionBlock: completionBlock)
//    }
//
//    func setUserParameters(userId: Int?,  completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        if userId != nil {
//            parameters["userId"] = userId
//        }
//
//        return request(address.setUserParameters, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getTrainerProfile(completionBlock: @escaping completionBlock) -> NetworkRequest {
//        return request(address.getTrainerProfile, method: .post, parameters: minParams, completionBlock: completionBlock)
//    }
//
//    func setTrainerWeekAvailability( completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        var parameters = minParams
//
//        return request(address.setTrainerWeekAvailability, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func setTracedBodyParam(targetValue: Double, userId: Int? = nil, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["targetValue"] = targetValue
//
//        if let userId = userId {
//            parameters["userId"] = userId
//        }
//
//        return request(address.setTracedBodyParam, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Calendar
//
//    func getCalendar(month: Int?, year: Int?, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        if month != nil, year != nil {
//            parameters["month"] = month
//            parameters["year"] = year
//        }
//
//        return request(address.getCalendar, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getDayDataForCalendar(monthDay: Int?, month: Int?, year: Int?, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        if monthDay != nil, month != nil, year != nil {
//            parameters["monthDay"] = monthDay
//            parameters["month"] = month
//            parameters["year"] = year
//        }
//
//        return request(address.getDayDataForCalendar, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func eatMeals(mealsId: [Int], completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["mealsId"] = mealsId
//
//        return request(address.eatMeals, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Charts
//
//    func getAllCharts(userId: Int?, completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        var parameters = minParams
//        if userId != nil {
//            parameters["userId"] = userId
//        }
//        return request(address.getAllCharts, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getChart(userId: Int?, pageIndex: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        var parameters = minParams
//        parameters["page"] = pageIndex
//        if userId != nil {
//            parameters["userId"] = userId
//        }
//
//        return request(address.getChart, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func setMainChart( completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        return request(address.setMainChart, method: .post, parameters: parameters,  completionBlock: completionBlock)
//    }
//
//    func getUnreadMessages(completionBlock: @escaping completionBlock) -> NetworkRequest {
//        return request(address.getUnreadMessages, method: .post, parameters: minParams, completionBlock: completionBlock)
//    }
//
//    //MARK: - Gallery
//
//    func getMyGallery(userId: Int? = nil, completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        var parameters = minParams
//
//        if let userId = userId {
//            parameters["userId"] = userId
//        }
//
//        return request(address.getMyGallery, method: .post, parameters: parameters,  completionBlock: completionBlock)
//    }
//
//    func uploadToGallery(image: UIImage, compressionQuality: CGFloat, type: String, title: String? = nil, userId: Int? = nil, completionBlock: @escaping completionBlock) {
//
//        let address = self.address.galleryUpload
//        var parameters = minParams
//        parameters["type"] = type
//
//        if let title = title {
//            parameters["title"] = title
//        }
//
//        if let userId = userId {
//            parameters["userId"] = String(userId)
//        }
//
//        let imgData = image.jpegData(compressionQuality: compressionQuality)!
//
//
//    }
//
//    //MARK: - Set Appointment
//
//    func getTrainerVisitInfo(trainerId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = trainerId
//
//        return request(address.getTrainerVisitInfo, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getTrainerAvailableHoursForDay(trainerId: Int, monthDay: Int, month: Int, year: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["trainerId"] = trainerId
//        parameters["monthDay"] = monthDay
//        parameters["month"] = month
//        parameters["year"] = year
//
//        return request(address.getTrainerAvailableHoursForDay, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Opinions
//
//    func getObjectOpinions(objectId: Int, page: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        parameters["objectId"] = String(objectId)
//        parameters["page"] = String(page)
//
//        return request(address.getObjectOpinions, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Settings
//
//    func setMySettingsForUser(general: Bool, visit: Bool, meal: Bool, workout: Bool, visitMinutesBefore: Int?, mealMinutesBefore: Int?, workoutHour: String?, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["general"] = general.description
//        parameters["visit"] = visit.description
//        parameters["workout"] = workout.description
//        parameters["meal"] = meal.description
//        if visitMinutesBefore != nil {
//            parameters["visitMinutesBefore"] = visitMinutesBefore
//        }
//        if mealMinutesBefore != nil {
//            parameters["mealMinutesBefore"] = mealMinutesBefore
//        }
//        if workoutHour != nil {
//            parameters["workoutHour"] = workoutHour
//        }
//
//        return request(address.setMySettings, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func setMySettingsForTrainer(general: Bool, subscriptionEnding: Bool, subscriptionEndingDaysBefore: Int?, subscriptionEndingTodaysHour: String?, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["general"] = general.description
//        parameters["subscriptionEnding"] = subscriptionEnding.description
//        if subscriptionEndingDaysBefore != nil {
//            parameters["subscriptionEndingDaysBefore"] = subscriptionEndingDaysBefore
//        }
//        if subscriptionEndingTodaysHour != nil {
//            parameters["subscriptionEndingTodaysHour"] = subscriptionEndingTodaysHour
//        }
//
//        return request(address.setMySettings, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getMySettings(completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        return request(address.getMySettings, method: .post, parameters: minParams, completionBlock: completionBlock)
//    }
//
//
//    //MARK: - AddMeToObject
//
//    func searchObjectsLite(text: String, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["text"] = text
//
//        return request(address.searchObjectsLite, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func addObjectToFindMeInObjects(objectId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["objectId"] = objectId
//
//        return request(address.addObjectToFindMeInObjects, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Chat
//
//    func getChatContacts(withNewContactId contactId: Int? = nil, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//
//        if let contactId = contactId {
//            parameters["id"] = contactId
//        }
//        return request(address.getChatContacts, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getChatWithContact(id: Int, afterTimestamp: String? = nil, beforeTimestamp: String? = nil, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["id"] = id
//
//        if let afterTimestamp = afterTimestamp {
//            parameters["afterTimestamp"] = afterTimestamp
//        }
//        if let beforeTimestamp = beforeTimestamp {
//            parameters["beforeTimestamp"] = beforeTimestamp
//        }
//
//        return request(address.getChatWithContact, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func sendMessageToContact(id: Int, message: String, completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        var parameters = minParams
//        parameters["id"] = String(id)
//        parameters["message"] = message
//
//        return request(address.sendMessageToContact, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - My trainers
//
//    func getMyTrainers(completionBlock: @escaping completionBlock) -> NetworkRequest {
//
//        return request(address.getMyTrainers, method: .post, parameters: minParams, completionBlock: completionBlock)
//    }
//
//    //MARK: - My clients
//
//    func addUserToMyClients(userId: Int, trades: [String:Bool],completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        for (key, value) in trades {
//            parameters[key] = value.description
//        }
//        parameters["userId"] = userId
//        return request(address.addUserToMyClients, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getMyClients(text: String?, sortByTrainingDate: String, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["text"] = text
//        parameters["sortByTrainingDate"] = sortByTrainingDate
//
//        return request(address.getMyClients, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func searchClientsLite(text: String?, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["text"] = text
//
//        return request(address.searchClientsLite, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getTrades(userId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["userId"] = userId
//
//        return request(address.getTrades, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Profile collection
//
//    func getLastUsedClients(page: Int, limit: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["page"] = page
//        parameters["limit"] = limit
//
//        return request(address.getLastUsedClients, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getFavouriteTrainers(page: Int, limit: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["page"] = page
//        parameters["limit"] = limit
//
//        return request(address.getFavouriteTrainers, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getFavouriteObjects(page: Int, limit: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["page"] = page
//        parameters["limit"] = limit
//
//        return request(address.getFavouriteObjects, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - Find me in objects
//
//    func getFindMeInObjects(text: String?, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["text"] = text
//        return request(address.getFindMeInObjects, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func removeObjectFromFindMeInObjects(objectId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["objectId"] = objectId
//
//        return request(address.removeObjectFromFindMeInObjects, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    // MARK: - Workout
//
//    func getWorkoutDays(completionBlock: @escaping completionBlock) -> NetworkRequest {
//        let parameters = minParams
//
//        return request(address.getWorkoutDays, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getWorkoutDetails(uniqueDayId: Int ,completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["uniqueDayId"] = uniqueDayId
//
//        return request(address.getWorkoutDetails, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func setWorkoutAsDone(uniqueDayId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["uniqueDayId"] = uniqueDayId
//
//        return request(address.setWorkoutAsDone, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    // MARK: - Exercise details
//
//    func getExerciseDetails(exerciseId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["exerciseId"] = String(exerciseId)
//
//        return request(address.getExerciseDetails, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    //MARK: - All day diet
//
//    func getMealForDay(month: String, monthDay: String, year: String, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["month"] = month
//        parameters["monthDay"] = monthDay
//        parameters["year"] = year
//
//        return request(address.getMealForDay, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func getMealIngredientReplacement(mealIngredientId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["mealIngredientId"] = mealIngredientId
//
//        return request(address.getMealIngredientReplacement, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func setMealIngredientAsMain(oldIngredientId: Int, newIngredientId: Int, uniqueDayId: Int, mealId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["oldMealIngredientId"] = oldIngredientId
//        parameters["newIngredientId"] = newIngredientId
//        parameters["uniqueDayId"] = uniqueDayId
//        parameters["mealId"] = mealId
//
//        return request(address.setMealIngredientAsMain, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    // MARK: - Exercise replacement
//
//    func getExerciseReplacement(uniqueDayId: Int, excersieId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["uniqueDayId"] = uniqueDayId
//        parameters["excerciseId"] = excersieId
//
//        return request(address.getExerciseReplacement, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func setExerciseAsMain(uniqueDayId: Int, oldExerciseId: Int, newExerciseId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["uniqueDayId"] = uniqueDayId
//        parameters["oldExerciseId"] = oldExerciseId
//        parameters["newExerciseId"] = newExerciseId
//
//        return request(address.setExerciseAsMain, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    // MARK: - Favourites
//
//    func addObjectToFavourites(objectId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["objectId"] = objectId
//
//        return request(address.addObjectToFavourites, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
//
//    func removeObjectFromFavourites(objectId: Int, completionBlock: @escaping completionBlock) -> NetworkRequest {
//        var parameters = minParams
//        parameters["objectId"] = objectId
//
//        return request(address.removeObjectFromFavourites, method: .post, parameters: parameters, completionBlock: completionBlock)
//    }
    
}
