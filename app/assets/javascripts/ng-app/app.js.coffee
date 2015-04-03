@scrumAid = angular.module("ScrumAid", [
  "ngRoute"
  "ngResource"
  "templates"
  "ngCookies"
  "ui.bootstrap"
])
scrumAid.config ($routeProvider, $locationProvider, $httpProvider) ->
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

  $httpProvider.interceptors.push('httpInterceptor')

scrumAid.factory 'httpInterceptor', ($q) ->
  {
    request: (config) ->
      config
    response: (result) ->
      result
    responseError: (error) ->
      error
  }