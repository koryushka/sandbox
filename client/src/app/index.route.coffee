# angular.module 'sandbox'
#   .config ($stateProvider, $urlRouterProvider) ->
#     'ngInject'
#     $stateProvider
angular.module "sandbox"
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'main',
        url: '/main',
        templateUrl: 'app/views/main.html',
        controller: 'PostsCtrl',
        controllerAs: 'main',
        activetab: 'main',
      .state "posts",
        url: "/posts",
        templateUrl: "app/views/posts.html",
        controller: "PostsCtrl",
        activetab: 'posts',
      .state "about",
        url: '/about',
        templateUrl: "app/views/about.html",
        controller: "PostsCtrl",
        activetab: 'about',
      .state "photos",
        url: '/photos',
        templateUrl: "app/views/photos.html",
        controller: "PostsCtrl",
        activetab: 'photos',
      .state "activity",
        url: '/activity',
        templateUrl: "app/views/activity.html",
        controller: "PostsCtrl",
        activetab: 'activity',
      .state "method",
        url: '/method',
        templateUrl: "app/views/method.html",
        controller: "PostsCtrl",
        activetab: 'method',
      .state "for_parents",
        url: '/for_parents',
        templateUrl: "app/views/for_parents.html",
        controller: "PostsCtrl",
        activetab: 'for_parents',
      .state "login",
        url: "/login",
        templateUrl: 'app/views/login.html',
        controller: "LoginCtrl"

    $urlRouterProvider.otherwise '/'
