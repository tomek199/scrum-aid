scrumAid.controller "DashboardCtrl", ($scope, DeviseService) ->
  $scope.ctrlName = "DashboardCtrl"

  $scope.currentUser = DeviseService.currentUser()
