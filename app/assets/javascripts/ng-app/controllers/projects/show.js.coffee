scrumAid.controller 'ProjectsShowCtrl', [
  '$scope','$routeParams', 'Restangular', 'CookiesFactory'
  ($scope, $routeParams, Restangular, CookiesFactory) ->
    $scope.project = {
      name: ""
      description: ""
    }

    Restangular.one('projects', $routeParams.id).get().then(
      (response) ->
        $scope.project = response
        CookiesFactory.putProject({_id: response._id, name: response.name})
    )

    $scope.$watch 'project.name', (newVal, oldVal) ->
      if !!newVal and !!oldVal
        updateAttribute({name: newVal})

    $scope.$watch 'project.description', (newVal, oldVal) ->
      if !!newVal and !!oldVal
        updateAttribute({description: newVal})

    updateAttribute = (property) ->
      project_id = $scope.project._id.$oid
      Restangular.all('projects').customPUT(property, project_id).then(
        (response) ->
          CookiesFactory.putProject({_id: response._id, name: response.name})
      )
]
