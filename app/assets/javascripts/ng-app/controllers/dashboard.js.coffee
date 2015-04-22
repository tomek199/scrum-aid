scrumAid.controller "DashboardCtrl", [
  '$scope', 'DeviseFactory'
  ($scope, DeviseFactory) ->
    $scope.ctrlName = "DashboardCtrl"

    $scope.currentUser = DeviseFactory.currentUser()
]
