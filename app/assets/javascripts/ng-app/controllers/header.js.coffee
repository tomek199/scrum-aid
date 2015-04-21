scrumAid.controller "HeaderCtrl", ($scope, $location, DeviseFactory) ->
  $scope.isAuthenticated = DeviseFactory.isAuthenticated
  $scope.currentUser = DeviseFactory.currentUser

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