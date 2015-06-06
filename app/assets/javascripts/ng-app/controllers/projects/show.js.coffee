scrumAid.controller 'ProjectsShowCtrl', [
  '$scope','$routeParams', 'ProjectsService', 'CookiesFactory'
  ($scope, $routeParams, ProjectsService, CookiesFactory) ->
    $scope.project = {
      name: ""
      description: ""
    }

    ProjectsService.show(id: $routeParams.id).$promise.then(
      (response) ->
        $scope.project = response
        CookiesFactory.putProject({_id: response._id, name: response.name})
      (error) ->
        console.log error
    )

    $scope.$watch 'project.name', (newVal, oldVal) ->
      if !!newVal and !!oldVal
        updateAttribute({name: newVal})

    $scope.$watch 'project.description', (newVal, oldVal) ->
      if !!newVal and !!oldVal
        updateAttribute({description: newVal})

    updateAttribute = (property) ->
      project_id = $scope.project._id.$oid
      ProjectsService.update(id: project_id, property).$promise.then(
        (response) ->
          CookiesFactory.putProject({_id: response._id, name: response.name})
        (error) ->
          console.log error
      )
]
