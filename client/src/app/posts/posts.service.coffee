# angular.module 'sandbox'
#   .factory "Post", (RailsResource) ->
#     class Post extends RailsResource
#       @configure url: "/api/posts", name: "post"
angular.module('sandbox').factory 'Item', ($resource) ->
  return $resource '/api/posts/:id', {id: "@id"}, {update: {method: "PUT"}}
