scrumAid.controller "SessionsCtrl", ($scope, $location, DeviseService) ->
  $scope.user = {}

  $scope.signUp = () ->
    $scope.user.password_confirmation = $scope.user.password
    DeviseService.signUp($scope.user,
      (success) ->
        if success._id != null and success._id != undefined and success.email == $scope.user.email
          $location.path '/dashboard'
      (error) ->
        console.log error
        $location.path '/'
    )
