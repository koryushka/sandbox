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
          token: response.data.access_token,
          refresh_token: response.data.refresh_token,
          logged_in: response.data.created_at,
          expires_in: response.data.expires_in
        user =   $localStorage.currentUser
        callback user
      ), (response) ->
        callback false
        return
      return

    RefreshToken = (refresh_token, callback) ->
      config = {
        headers : {
          'Content-Type': 'application/json'
        }
      }
      url = 'http://localhost:3000/oauth/token'
      $http.post(url, {refresh_token: refresh_token, grant_type: 'refresh_token'}, config).then ((response) ->
        $localStorage.currentUser =
          username: $localStorage.currentUser.username,
          token: response.data.access_token,
          refresh_token: response.data.refresh_token,
          logged_in: response.data.created_at,
          expires_in: response.data.expires_in
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
    service.RefreshToken = RefreshToken
    service

  'use strict'
  angular.module('sandbox').factory 'AuthenticationService', Service
  return
