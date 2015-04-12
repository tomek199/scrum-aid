scrumAid.controller "SessionsCtrl", ($scope, $location, DeviseService) ->
  $scope.user = {}

  if DeviseService.isAuthenticated() == true
    $location.path '/dashboard'

  $scope.signUp = () ->
    $scope.user.password_confirmation = $scope.user.password
    DeviseService.signUp($scope.user,
      (success) ->
        if success._id? and success.email == $scope.user.email
          $location.path '/dashboard'
      (error) ->
        console.log error
    )

  $scope.signIn = () ->
    DeviseService.signIn($scope.user,
      (success) ->
        if success._id? and success.email = $scope.user.email
          $location.path '/dashboard'
      (error) ->
        console.log error
    )