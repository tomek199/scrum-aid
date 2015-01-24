@scrumAid = angular.module("ScrumAid", [
  "ngRoute"
  "templates"
])
scrumAid.config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    templateUrl: "home.html"
    controller: "HomeCtrl"

  $locationProvider.html5Mode
    enabled: true
    requireBase: false