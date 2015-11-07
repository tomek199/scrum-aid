scrumAid.controller 'ProjectsNavCtrl', [
  '$scope', '$routeParams'
  ($scope, $routeParams) ->
    $scope.tabs = [
      {
        title: 'Overview'
        href: '/projects/' + $routeParams.project_id
      }
      {
        title: 'Users'
        href: '/projects/' + $routeParams.project_id + '/users'
      }
      {
        title: 'Sprint'
        href: '/projects/' + $routeParams.project_id + '/sprints'
      }
      {
        title: 'Retrospective'
        href: '/projects/' + $routeParams.project_id + '/retrospectives'
      }
      {
        title: "Notes"
        href: '/projects/' + $routeParams.project_id + '/notebooks'
      }
    ]
]
