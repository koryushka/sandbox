# angular.module "sandbox"
#   .controller "PostsCtrl", ($scope, Post) ->
# angular.module 'sandbox',[]
angular.module 'sandbox'
  .controller 'PostsCtrl', ($scope, Item, $sce, $localStorage, $http, $location, $mdDialog) ->
    $scope.currentUser = $localStorage.currentUser
    $scope.imagePath = 'https://material.angularjs.org/latest/img/washedout.png'
    if $scope.currentUser
      $http.defaults.headers.common['Authorization'] = 'Bearer ' + $scope.currentUser.token
    $scope.showForm = true

    $scope.path = $location.path()

    $scope.showEditForm =(arg) ->
      $scope.showForm = arg

    $scope.posts = Item.query(scope: $scope.path.slice(1))

    $scope.addPost =(post, scope) ->
      item = Item.save(post, scope: scope)
      if item
        $scope.posts.unshift(item)
        $scope.Item = {}

    $scope.removePost =(idx) ->
      post_to_delete = $scope.posts[idx]
      Item.delete { id: post_to_delete.id }, (success) ->
        $scope.posts.splice idx, 1
        return

    $scope.codeToHtml =(code) ->
      $sce.trustAsHtml(code)

    $scope.updatePost =(post) ->
      $scope.showEditForm(true)
      return post.$update()

    $scope.getContent = ->
      console.log 'Editor content:', $scope.tinymceModel
      return

    $scope.setContent = ->
      $scope.tinymceModel = 'Time: ' + new Date
      return
    $scope.hideCreationForm =() ->
      $scope.showForm = false

    chunk = (arr, size) ->
      newArr = []
      i = 0
      while i < arr.length
        newArr.push(arr.slice(i, i + size))
        i += size
      newArr

    $scope.chunkedData = chunk($scope.posts, 3)

    $scope.tinymceOptions =
      # plugins: 'link image code'
      # toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify '+
      #   '| bullist numlist outdent indent | link image | print preview media | forecolor backcolor emoticons'

      height: 500,
      theme: 'modern',
      plugins: [
        'advlist autolink lists link image charmap print preview hr anchor pagebreak',
        'searchreplace wordcount visualblocks visualchars code fullscreen',
        'insertdatetime media nonbreaking save table contextmenu directionality',
        'emoticons template paste textcolor colorpicker textpattern imagetools '
      ],
      toolbar1: '"sizeselect | bold italic | fontselect |  fontsizeselect | '+
        'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify'+
        ' | bullist numlist outdent indent | link image',
      toolbar2: 'print preview media | forecolor backcolor emoticons',
      fontsize_formats: "8pt 10pt 12pt 14pt 18pt 24pt 36pt",
      image_advtab: true,
      templates: [
        { title: 'Test template 1', content: 'Test 1' },
        { title: 'Test template 2', content: 'Test 2' }
      ],
      content_css: [
        '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
        '//www.tinymce.com/css/codepen.min.css'
      ]
    # return
    # $scope.post = Item.get({ id: $scope.id }, ->
    #   # console.log post
    #   return
    # )
    # get() returns a single entry

    # #query() returns all the entries
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
