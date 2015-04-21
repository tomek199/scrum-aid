scrumAid.controller "DashboardCtrl", ($scope, DeviseFactory) ->
  $scope.ctrlName = "DashboardCtrl"

  $scope.currentUser = DeviseFactory.currentUser()
