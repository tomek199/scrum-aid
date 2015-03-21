@scrumAid = angular.module("ScrumAid", [
  "ngRoute"
  "templates"
  "ui.bootstrap"
])
scrumAid.config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    templateUrl: "register.html"
    controller: "RegisterCtrl"
  $routeProvider.when "/register",
    templateUrl: "register.html"
    controller: "RegisterCtrl"
  $routeProvider.otherwise
    templateUrl: "register.html"
    controller: "RegisterCtrl"

  $locationProvider.html5Mode
    enabled: true
    requireBase: false