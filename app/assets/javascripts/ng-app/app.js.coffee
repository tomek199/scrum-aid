@scrumAid = angular.module("ScrumAid", [
  "ngRoute"
  "ngResource"
  "templates"
  "ngCookies"
  "ui.bootstrap"
])
scrumAid.config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    templateUrl: "register.html"
    controller: "SessionsCtrl"
  $routeProvider.when "/register",
    templateUrl: "register.html"
    controller: "SessionsCtrl"
  $routeProvider.when "/dashboard",
    templateUrl: "dashboard.html"
    controller: "DashboardCtrl"
  $routeProvider.otherwise
    templateUrl: "register.html"
    controller: "SessionsCtrl"

  $locationProvider.html5Mode
    enabled: true
    requireBase: false