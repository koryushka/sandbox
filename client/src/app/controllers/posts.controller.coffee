# angular.module "sandbox"
#   .controller "PostsCtrl", ($scope, Post) ->
# angular.module 'sandbox',[]
angular.module 'sandbox'
  .controller 'PostsCtrl', ($scope, Item, Image, $sce, $localStorage, $http, $location, $mdDialog, AuthenticationService, FileUploader) ->
    $scope.currentUser = $localStorage.currentUser
    $scope.showRoom = false
    $scope.imagePath = 'https://material.angularjs.org/latest/img/washedout.png'
    $scope.currentPage = 0
    $scope.itemsPerPage = 2
    # $scope.uploader = new FileUploader({url: 'http://localhost:3000/images'})

    $scope.refreshToken = ->
      AuthenticationService.RefreshToken $scope.currentUser.refresh_token,(result)->
        if result
          console.debug result
          console.debug('RefreshToken Succeed')
          # $scope.currentUser = result
          $scope.currentUser = $localStorage.currentUser
          $location.path '/main'
        else
          console.debug('RefreshToken Failed')
        return
      return

    if $scope.currentUser
      if new Date()/1000 - $scope.currentUser.logged_in > $scope.currentUser.expires_in
        console.debug('Expired')
        $scope.refreshToken()
      $http.defaults.headers.common['Authorization'] = 'Bearer ' + $scope.currentUser.token
    $scope.showForm = true



    $scope.firstPage = ->
      $scope.currentPage == 0

    $scope.lastPage = ->
      lastPageNum = Math.ceil($scope.posts.length / $scope.itemsPerPage - 1)
      $scope.currentPage == lastPageNum

    $scope.numberOfPages = ->
      Math.ceil $scope.posts.length / $scope.itemsPerPage

    $scope.startingItem = ->
      $scope.currentPage * $scope.itemsPerPage

    $scope.pageBack = ->
      $scope.currentPage = $scope.currentPage - 1
      return

    $scope.pageForward = ->
      $scope.currentPage = $scope.currentPage + 1
      return

    path = $location.path()

    $scope.showEditForm =(arg) ->
      $scope.showForm = arg

    # $scope.getPosts =()->
    #   posts = Item.query(scope: path.slice(1)).$promise.then (response) ->
    #   # $scope.posts= response.posts
    #   #   console.debug(response)
    #
    #     $scope.posts = response.posts
    #     return
    #   return
    # $scope.posts = $scope.getPosts()

    # $scope.getPosts()

    Item.query(scope: path.slice(1)).$promise.then (data) ->
      $scope.posts = data.posts
      $scope.chunkedData = chunk($scope.posts, 3)
      return

    $scope.addPost =(post, scope) ->
      item = Item.save(post: post, scope: scope)
      console.debug item
      if item
        $scope.posts.unshift(item.post)
        $scope.chunkedData = chunk($scope.posts, 3)
        $scope.Item = {}

    $scope.removePost =(idx) ->
      post_to_delete = $scope.posts[idx]
      Item.delete { id: post_to_delete.id }, (success) ->
        $scope.posts.splice idx, 1
        $scope.chunkedData = chunk($scope.posts, 3)
        return

    $scope.codeToHtml =(code) ->
      $sce.trustAsHtml(code)

    $scope.updatePost =(post) ->
      $scope.showEditForm(true)
      console.debug post
      return Item.update({id: post.id, post: {title: post.title, body: post.body}})


    $scope.setEditing =(arg)->
      $scope.editing = arg

    $scope.showPost =(post) ->
      $scope.showRoom = true
      $scope.room = post
      id = post.id
      $scope.url = "http://localhost:9000/api/posts/" + id + "/images"
      CKEDITOR.config.filebrowserUploadUrl = $scope.url# + $scope.post.id

    $scope.hideRoom =->
      $scope.showRoom = false

    $scope.setAsBanner =(image)->
      Image.update({id: image.id, image: {is_banner: true}}).$promise.then (data) ->
        console.debug data.image

    # $scope.getContent = ->
    #   console.log 'Editor content:', $scope.tinymceModel
    #   return

    # $scope.setContent = ->
    #   $scope.tinymceModel = 'Time: ' + new Date
    #   return
    $scope.hideCreationForm =() ->
      $scope.showForm = false

    # $scope.deleteImage =(post, idx)->
    #   image_to_delete = post.images[idx]
    #   Image.delete { id: image_to_delete.id }, (success) ->
    #     post.images.splice idx, 1
    #     return

    # $scope.makeBanner =(post, image)->


    chunk = (arr, size) ->
      newArr = []
      i = 0
      console.debug arr
      while i < arr.length
        newArr.push arr.slice(i, i + size)
        i += size
      newArr



    $scope.editorOptions = {
      language: 'ru',
      uiColor: '#000000'
    }

    # CKEDITOR.config.filebrowserUploadUrl = 'http://localhost:9000/api/posts/'+ $scope.post_id + '/images' # + $scope.post.id

    $scope.post = new Item

    $scope.showConfirm = (ev, idx) ->
      # Appending dialog to document.body to cover sidenav in docs app
      confirm = $mdDialog.confirm().title('Удалить запись ' + $scope.posts[idx].title + '?')
        .textContent('Запись будет удалена без возможности восстановления.')
        .ariaLabel('Lucky day')
        .targetEvent(ev)
        .ok('Да!')
        .cancel('Отмена')
      $mdDialog.show(confirm).then (->
        $scope.removePost(idx)
        return
    ), ->
      return
    return
