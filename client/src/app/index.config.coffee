angular.module 'sandbox'
  .filter 'startFrom', ->
    (input, start) ->
      if input
        start = +start
        # parse to int
        return input.slice(start)
      []
  .config ($logProvider, toastrConfig) ->
    # 'ngInject'
    # Enable log
    $logProvider.debugEnabled true
    # Set options third-party lib
    toastrConfig.allowHtml = true
    toastrConfig.timeOut = 3000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = true
    toastrConfig.progressBar = true
