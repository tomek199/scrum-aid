scrumAid.controller "SessionsCtrl", [
  '$scope', '$location', 'DeviseFactory'
  ($scope, $location, DeviseFactory) ->
    $scope.user = {}

    if DeviseFactory.isAuthenticated() == true
      $location.path '/dashboard'

    $scope.signUp = () ->
      $scope.user.password_confirmation = $scope.user.password
      DeviseFactory.signUp($scope.user,
        (success) ->
          if success._id? and success.email == $scope.user.email
            $location.path '/dashboard'
        (error) ->
          console.log error
      )

    $scope.signIn = () ->
      DeviseFactory.signIn($scope.user,
        (success) ->
          if success._id? and success.email = $scope.user.email
            $location.path '/dashboard'
        (error) ->
          console.log error
      )
]
