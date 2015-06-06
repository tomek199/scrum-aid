scrumAid.controller 'ProjectsNavCtrl', [
  '$scope', '$location', 'CookiesFactory'
  ($scope, $location, CookiesFactory) ->
    $scope.currentProject = CookiesFactory.getProject
    $scope.tabs = [
      {
        title: 'Overview'
        href: '/projects/' + $scope.currentProject()._id.$oid
      }
      {
        title: 'Users'
        href: '/projects/' + $scope.currentProject()._id.$oid + '/users'
      }
    ]
]
