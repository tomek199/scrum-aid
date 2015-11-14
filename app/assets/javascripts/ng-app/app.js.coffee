@scrumAid = angular.module("ScrumAid", [
  "ngRoute"
  "templates"
  "ngCookies"
  "ui.bootstrap"
  "ui.calendar"
  "xeditable"
  "restangular"
])
scrumAid.config ($routeProvider, $locationProvider, $httpProvider) ->
# Sessions
  $routeProvider.when "/",
    templateUrl: "devise/register.html"
    controller: "SessionsCtrl"
  $routeProvider.when "/register",
    templateUrl: "devise/register.html"
    controller: "SessionsCtrl"
  $routeProvider.when "/login",
    templateUrl: "devise/login.html"
    controller: "SessionsCtrl"
  $routeProvider.otherwise
    templateUrl: "devise/register.html"
    controller: "SessionsCtrl"
# Dashboard
  $routeProvider.when "/dashboard",
    templateUrl: "dashboard/dashboard.html"
    controller: "DashboardCtrl"
# Projects
  $routeProvider.when "/projects",
    templateUrl: "projects/index.html"
    controller: "ProjectsIndexCtrl"
  $routeProvider.when "/projects/:project_id",
    templateUrl: "projects/show.html"
    controller: "ProjectsShowCtrl"
# Users
  $routeProvider.when "/projects/:project_id/users",
    templateUrl: "users/index.html"
    controller: "UsersIndexCtrl"
# Sprints
  $routeProvider.when "/projects/:project_id/sprints",
    templateUrl: "sprints/index.html"
    controller: "SprintsIndexCtrl"
  $routeProvider.when "/projects/:project_id/sprints/:sprint_id",
    templateUrl: "sprints/show.html"
    controller: "SprintsShowCtrl"
# Retrospectives
  $routeProvider.when "/projects/:project_id/retrospectives",
    templateUrl: "retrospectives/index.html"
    controller: "RetrospectivesIndexCtrl"
  $routeProvider.when "/projects/:project_id/sprints/:sprint_id/retrospectives",
    templateUrl: "retrospectives/index.html"
    controller: "RetrospectivesIndexCtrl"
  $routeProvider.when "/projects/:project_id/sprints/:sprint_id/retrospectives/new",
    templateUrl: "retrospectives/add.html"
    controller: "RetrospectivesCreateCtrl"
  $routeProvider.when "/projects/:project_id/sprints/:sprint_id/retrospectives/:retrospective_id/edit",
    templateUrl: "retrospectives/edit.html"
    controller: "RetrospectivesUpdateCtrl"
# Notebooks
  $routeProvider.when "/projects/:project_id/notebooks",
    templateUrl: "notebooks/index.html"
    controller: "NotebooksIndexCtrl"
# Notes
  $routeProvider.when "/projects/:project_id/notebooks/:notebook_id/notes",
    templateUrl: "notes/index.html"
    controller: "NotesIndexCtrl"

  $locationProvider.html5Mode
    enabled: true
    requireBase: false

  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');

  $httpProvider.interceptors.push('httpInterceptor')

scrumAid.run (editableOptions) ->
  editableOptions.theme = 'bs3'

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
