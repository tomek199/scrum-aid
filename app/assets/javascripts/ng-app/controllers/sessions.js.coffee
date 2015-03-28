scrumAid.controller "SessionsCtrl", ($scope, DeviseService) ->
  $scope.user = {}

  $scope.signUp = () ->
    $scope.user.password_confirmation = $scope.user.password
    DeviseService.signUp(user: $scope.user).$promise.then (
      (value) ->
        console.log value
    ), (error) ->
      console.log error
      alert "Registration failure"
