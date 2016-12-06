# angular.module 'sandbox'
#   .factory "Post", (RailsResource) ->
#     class Post extends RailsResource
#       @configure url: "/api/posts", name: "post"
angular.module('sandbox').factory 'Image', ($resource) ->
  return $resource '/api/images/:id', {id: "@id"}, {update: {method: "PUT"}}
