scrumAid.controller "DashboardCtrl", [
  '$scope', 'CookiesFactory'
  ($scope, CookiesFactory) ->
    $scope.ctrlName = "DashboardCtrl"

    $scope.currentUser = CookiesFactory.getUser()
]
