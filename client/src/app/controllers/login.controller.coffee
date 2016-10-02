do ->

  Controller = ($scope, $location, AuthenticationService, $localStorage, $window) ->
    $scope.vm = this
    $scope.currentUser = $localStorage.currentUser

    initController = ->
      AuthenticationService.Logout()
      return

    $scope.login = ->
      AuthenticationService.Login $scope.vm.username, $scope.vm.password, (result) ->
        if result
          console.debug result
          # $scope.currentUser = result
          $scope.currentUser = $localStorage.currentUser
          $location.path '/login'
        else
          $scope.vm.error = 'Username or password is incorrect'
        return
      return

    $scope.logout = ->
      AuthenticationService.Logout()
      $scope.currentUser = null
      $location.path '/'
      return

    $scope.vm.login = $scope.login
    # initController()
    return

  'use strict'
  angular.module('sandbox').controller 'LoginCtrl', Controller
  return
