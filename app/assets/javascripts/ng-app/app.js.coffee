@scrumAid = angular.module("ScrumAid", [
  "ngRoute"
  "ngResource"
  "templates"
  "ngCookies"
  "ui.bootstrap"
])
scrumAid.config ($routeProvider, $locationProvider, $httpProvider) ->
  $routeProvider.when "/",
    templateUrl: "devise/register.html"
    controller: "SessionsCtrl"
  $routeProvider.when "/register",
    templateUrl: "devise/register.html"
    controller: "SessionsCtrl"
  $routeProvider.when "/login",
    templateUrl: "devise/login.html"
    controller: "SessionsCtrl"
  $routeProvider.when "/dashboard",
    templateUrl: "dashboard/dashboard.html"
    controller: "DashboardCtrl"

  $routeProvider.when "/projects",
    templateUrl: "projects/index.html"
    controller: "ProjectsIndexCtrl"
  $routeProvider.otherwise
    templateUrl: "devise/register.html"
    controller: "SessionsCtrl"

  $locationProvider.html5Mode
    enabled: true
    requireBase: false

  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');

  $httpProvider.interceptors.push('httpInterceptor')

scrumAid.factory 'httpInterceptor', [
  '$q'
  ($q) ->
    {
      request: (config) ->
        config
      response: (result) ->
        result
      responseError: (error) ->
        error
    }
]
