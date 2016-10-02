# angular.module 'sandbox'
#   .config ($stateProvider, $urlRouterProvider) ->
#     'ngInject'
#     $stateProvider
angular.module "sandbox"
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'home',
        url: '/',
        templateUrl: 'app/views/main.html',
        controller: 'MainCtrl',
        controllerAs: 'main',
        activetab: 'home',
      .state "posts",
        url: "/posts",
        templateUrl: "app/views/posts.html",
        controller: "PostsCtrl",
        activetab: 'posts',
      .state "login",
        url: "/login",
        templateUrl: 'app/views/login.html',
        controller: "LoginCtrl"

    $urlRouterProvider.otherwise '/'
