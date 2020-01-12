//
//  ViewController.swift
//  FriendshipDiary
//
//  Created by Mateusz on 04/01/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import Foundation

struct Link {
    
    let endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    var full: String { return NetworkURL.baseAddress + endpoint }
}

class NetworkURL {
    
    static let baseAddress: String = "http://friendshipdiary.westeurope.azurecontainer.io:5000/api/"

    let postLogin = Link(endpoint: "login")
    let postRegister = Link(endpoint: "register")
    
    // Memories
    let getMemories = Link(endpoint: "memories")
    let getMemoriesDraft = Link(endpoint: "memories/draft")
    let postMemoriesDraft = Link(endpoint: "memories/draft")
    
    // Search
    let searchObjects = Link(endpoint: "searchObjects")
    let searchDisciplines = Link(endpoint: "searchDisciplines")
    let searchTrainers = Link(endpoint: "searchTrainers")
    let getTrainersOfObject = Link(endpoint: "getTrainersOfObject")
    let getTrainersOfDiscipline = Link(endpoint: "getTrainersOfDiscipline")
    
    // Details
    let getTrainerDetails = Link(endpoint: "getTrainerDetails")
    let addTrainerToFavourites = Link(endpoint: "addTrainerToFavourites")
    let removeTrainerFromFavourites = Link(endpoint: "removeTrainerFromFavourites")
    let removeTrainerFromMyTrainers = Link(endpoint: "removeTrainerFromMyTrainers")
    let getTrainerOpinions = Link(endpoint: "getTrainerOpinions")
    let getObjectDetails = Link(endpoint: "getObjectDetails")
    let getObjectOpinions = Link(endpoint: "getObjectOpinions")
    let requestVisitWithTrainer = Link(endpoint: "requestVisitWithTrainer")
    let getClientDetails = Link(endpoint: "getClientDetails")
    let saveNotesAboutClient = Link(endpoint: "saveNotesAboutClient")
    let signInToEvent = Link(endpoint: "signInToEvent")
    let signOutToEvent = Link(endpoint: "signOutToEvent")
    let getObjectEvents = Link(endpoint: "getObjectEvents")
    let addObjectToFavourites = Link(endpoint: "addObjectToFavourites")
    let removeObjectFromFavourites = Link(endpoint: "removeObjectFromFavourites")
    let removeUserFromMyClients = Link(endpoint: "removeUserFromMyClients")
    let setFitManagerAccess = Link(endpoint: "setFitManagerAccess")
    
    // Visit history
    let getMyVisits = Link(endpoint: "getMyVisits")
    let changeVisitDate = Link(endpoint: "changeVisitDate")
    let cancelVisit = Link(endpoint: "cancelVisit")
    let acceptVisit = Link(endpoint: "acceptVisit")
    let confirmInvitation = Link(endpoint: "confirmInvitation")
    let refuseInvitation = Link(endpoint: "refuseInvitation")
    
    //Profile
    let getUserProfile = Link(endpoint: "getUserProfile")
    let setUserParameters = Link(endpoint: "setUserParameters")
    let getTrainerProfile = Link(endpoint: "getTrainerProfile")
    let setTracedBodyParam = Link(endpoint: "setTracedBodyParam")
    let setTrainerWeekAvailability = Link(endpoint: "setTrainerWeekAvailability")
    
    //Calendar
    let getCalendar = Link(endpoint: "getCalendar")
    let getDayDataForCalendar = Link(endpoint: "getDayDataForCalendar")
    let eatMeals = Link(endpoint: "eatMeals")
    
    // Chart
    let getAllCharts = Link(endpoint: "getAllCharts")
    let getChart = Link(endpoint: "getChart")
    let setMainChart = Link(endpoint: "setMainChart")
    
    // Gallery
    let getMyGallery = Link(endpoint: "getMyGallery")
    let galleryUpload = Link(endpoint: "upload")
    
    //Set Appointment
    let getTrainerVisitInfo = Link(endpoint: "getTrainerVisitInfo")
    let getTrainerAvailableHoursForDay = Link(endpoint: "getTrainerAvailableHoursForDay")
    
    // Add me to object
    let searchObjectsLite = Link(endpoint: "searchObjectsLite")
    let addObjectToFindMeInObjects = Link(endpoint: "addObjectToFindMeInObjects")
    
    // Chat
    let getChatContacts = Link(endpoint: "getChatContacts")
    let getChatWithContact = Link(endpoint: "getChatWithContact")
    let sendMessageToContact = Link(endpoint: "sendMessageToContact")
    let getUnreadMessages = Link(endpoint: "getUnreadMessages")
    
    //MyClients
    let getMyClients = Link(endpoint: "getMyClients")
    let searchClientsLite = Link(endpoint: "searchClientsLite")
    let getTrades = Link(endpoint: "getTrades")
    let addUserToMyClients = Link(endpoint: "addUserToMyClients")
    
    //MyTrainers
    let getMyTrainers = Link(endpoint: "getMyTrainers")
    
    //Profile collection
    
    let getLastUsedClients = Link(endpoint: "getLastUsedClients")
    let getFavouriteTrainers = Link(endpoint: "getFavouriteTrainers")
    let getFavouriteObjects = Link(endpoint: "getFavouriteObjects")
    
    // Settings
    let setMySettings = Link(endpoint: "setMySettings")
    let getMySettings = Link(endpoint: "getMySetting")
    
    // Find me in objects
    let getFindMeInObjects = Link(endpoint: "getFindMeInObjects")
    let removeObjectFromFindMeInObjects = Link(endpoint: "removeObjectFromFindMeInObjects")
    
    // Workout
    let getWorkoutDays = Link(endpoint: "getWorkoutDays")
    let getWorkoutDetails = Link(endpoint: "getWorkoutDetails")
    let setWorkoutAsDone = Link(endpoint: "setWorkoutAsDone")
    
    // Exercise details
    let getExerciseDetails = Link(endpoint: "getExerciseDetails")
    
    // All day diet
    let getMealForDay = Link(endpoint: "getMealForDay")
    let getMealIngredientReplacement = Link(endpoint: "getMealIngredientReplacement")
    let setMealIngredientAsMain = Link(endpoint: "setMealIngredientAsMain")
    
    // Exercise replacement
    let getExerciseReplacement = Link(endpoint: "getExerciseReplacement")
    let setExerciseAsMain = Link(endpoint: "setExerciseAsMain")
}
