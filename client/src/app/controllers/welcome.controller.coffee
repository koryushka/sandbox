angular.module 'sandbox'
  .controller 'WelcomeCtrl', ($scope, $localStorage) ->
    $scope.currentUser = $localStorage.currentUser
    $scope.test = 'TEST'
