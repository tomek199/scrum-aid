scrumAid.controller "HeaderCtrl", [
  '$scope', '$location', 'DeviseFactory', 'CookiesFactory', 'ProjectsService'
  ($scope, $location, DeviseFactory, CookiesFactory, ProjectsService) ->
    $scope.isAuthenticated = DeviseFactory.isAuthenticated
    $scope.currentUser = DeviseFactory.currentUser
    $scope.projects = []
    $scope.currentProject = CookiesFactory.getProject

    if $scope.isAuthenticated() == false
      $location.path '/login'

    $scope.signOut = () ->
      DeviseFactory.signOut(
        (success) ->
          $location.path '/login'
        (error) ->
          console.log(error)
          $location.path '/'
      )

    $scope.redirectTo = (path) ->
      $location.path path

    $scope.getProjects = () ->
      ProjectsService.index().$promise.then(
        (response) ->
          $scope.projects = response
        (error) ->
          console.log error
      )

    $scope.projectShow = (index) ->
      if typeof(index) == 'object'
        id = index.$oid
      else
        id = $scope.projects[index]._id.$oid
      $location.path '/projects/' + id
]
