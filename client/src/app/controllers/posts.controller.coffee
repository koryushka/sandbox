# angular.module "sandbox"
#   .controller "PostsCtrl", ($scope, Post) ->
# angular.module 'sandbox',[]
angular.module 'sandbox'
  .controller 'PostsCtrl', ($scope, Item) ->

    $scope.posts = Item.query()

    $scope.addPost =(post) ->
      item = Item.save post
      if item
        $scope.posts.push(item)
        $scope.Item = {}

    $scope.removePost =(idx) ->
      post_to_delete = $scope.posts[idx]
      Item.delete { id: post_to_delete.id }, (success) ->
        $scope.posts.splice idx, 1
        return

    # $scope.editPost =()->
    #   $scope.showEditForm = true

    $scope.updatePost =(post) ->
      return post.$update()

    # $scope.tinymceModel = 'Initial content!!!'

    $scope.getContent = ->
      console.log 'Editor content:', $scope.tinymceModel
      return

    $scope.setContent = ->
      $scope.tinymceModel = 'Time: ' + new Date
      return

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
        'emoticons template paste textcolor colorpicker textpattern imagetools'
      ],
      toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify'+
        ' | bullist numlist outdent indent | link image',
      toolbar2: 'print preview media | forecolor backcolor emoticons',
      image_advtab: true,
      templates: [
        { title: 'Test template 1', content: 'Test 1' },
        { title: 'Test template 2', content: 'Test 2' }
      ],
      content_css: [
        '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
        '//www.tinymce.com/css/codepen.min.css'
      ]
    return
    # $scope.post = Item.get({ id: $scope.id }, ->
    #   # console.log post
    #   return
    # )
    # get() returns a single entry

    # #query() returns all the entries
    $scope.post = new Item
    # #You can instantiate resource class
    # $scope.post.title = 'some data'
    # Item.save $scope.post, ->
    #   #data saved. do something here.
    #   return
    #saves an entry. Assuming $scope.entry is the Entry object
    return

  # ---
  # generated by js2coffee 2.2.0
