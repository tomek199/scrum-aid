scrumAid.controller "HeaderCtrl", ($scope, $location, DeviseService) ->
  $scope.isAuthenticated = DeviseService.isAuthenticated

  $scope.signOut = () ->
    DeviseService.signOut(
      (success) ->
        $location.path '/'
      (error) ->
        console.log(error)
        $location.path '/'
    )