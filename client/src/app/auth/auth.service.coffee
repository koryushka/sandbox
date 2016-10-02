do ->

  Service = ($http, $localStorage) ->
    service = {}


    Login = (username, password, callback) ->
      config = {
        headers : {
          'Content-Type': 'application/json'
        }
      }
      url = 'http://localhost:3000/oauth/token'

      $http.post(url, {username: username, password: password, grant_type: 'password'}, config).then ((response) ->
        $localStorage.currentUser =
          username: username,
          token: response.data.access_token
        user =   $localStorage.currentUser
        callback user
      ), (response) ->
        callback false
        return
      return

    Logout = ->
      # remove user from local storage and clear http auth header
      delete $localStorage.currentUser
      $http.defaults.headers.common.Authorization = ''
      return

    service.Login = Login
    service.Logout = Logout
    service

  'use strict'
  angular.module('sandbox').factory 'AuthenticationService', Service
  return
