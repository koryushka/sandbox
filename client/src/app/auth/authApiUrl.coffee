if window.document and window.document.baseURI and window.document.baseURI == 'http://localhost:9000/'
  angular.module('sandbox').constant 'apiUrl', 'http://localhost:3000/'
else
  angular.module('sandbox').constant 'apiUrl', 'https://weezlabs.herokuapp.com/api'
