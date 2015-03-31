scrumAid.controller "DashboardCtrl", ($scope, DeviseService) ->
  $scope.ctrlName = "DashboardCtrl"

  DeviseService.currentUser((result) ->
    $scope.currentUser = result
  )