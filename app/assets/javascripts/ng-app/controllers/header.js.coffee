scrumAid.controller "HeaderCtrl", ($scope, $location, DeviseService) ->
  $scope.isAuthenticated = DeviseService.isAuthenticated
  $scope.currentUser = DeviseService.currentUser

  if $scope.isAuthenticated() == false
    $location.path '/login'

  $scope.signOut = () ->
    DeviseService.signOut(
      (success) ->
        $location.path '/login'
      (error) ->
        console.log(error)
        $location.path '/'
    )

  $scope.redirectTo = (path) ->
    $location.path path