scrumAid.controller 'ProjectsShowCtrl', [
  '$scope','$routeParams', 'ProjectsService', 'CookiesFactory'
  ($scope, $routeParams, ProjectsService, CookiesFactory) ->
    $scope.project = {}

    ProjectsService.show(id: $routeParams.id).$promise.then(
      (response) ->
        $scope.project = response
        CookiesFactory.putProject({_id: response._id, name: response.name})
      (error) ->
        console.log error
    )
]
