angular.module 'sandbox'
  .run ($rootScope, $location, $anchorScroll) ->
    #when the route is changed scroll to the proper element.
    $rootScope.$on '$routeChangeSuccess', (newRoute, oldRoute) ->
      if $location.hash()
        $anchorScroll()
      return
    return
  .run ($log) ->
    'ngInject'
    $log.debug 'runBlock end'
