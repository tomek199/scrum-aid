scrumAid.controller 'ProjectsNavCtrl', [
  '$scope', '$routeParams'
  ($scope, $routeParams) ->
    $scope.tabs = [
      {
        title: 'Overview'
        href: '/projects/' + $routeParams.id
      }
      {
        title: 'Users'
        href: '/projects/' + $routeParams.id + '/users'
      }
    ]
]
