scrumAid.controller "HeaderCtrl", [
  '$scope', '$location', 'Restangular', 'DeviseFactory', 'CookiesFactory'
  ($scope, $location, Restangular, DeviseFactory, CookiesFactory) ->
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
      Restangular.all('projects').getList().then(
        (response) ->
          $scope.projects = response
      )

    $scope.isCurrentProject = () ->
      if $scope.currentProject()
        return true
      else
        return false

    $scope.projectShow = (index) ->
      if typeof(index) == 'object'
        id = index.$oid
      else
        id = $scope.projects[index]._id.$oid
      $location.path '/projects/' + id
]
