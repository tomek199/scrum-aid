scrumAid.controller "HeaderCtrl", ($scope, DeviseService) ->
  $scope.isAuthenticated = DeviseService.isAuthenticated

