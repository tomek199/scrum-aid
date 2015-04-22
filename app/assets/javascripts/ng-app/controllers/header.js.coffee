scrumAid.controller "HeaderCtrl", ($scope, $location, DeviseFactory, ProjectsService) ->
  $scope.isAuthenticated = DeviseFactory.isAuthenticated
  $scope.currentUser = DeviseFactory.currentUser
  $scope.projects = []

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
    console.log index
    # todo