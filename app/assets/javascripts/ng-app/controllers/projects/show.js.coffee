scrumAid.controller 'ProjectsShowCtrl', [
  '$scope','$routeParams', 'Restangular', 'CookiesFactory'
  ($scope, $routeParams, Restangular, CookiesFactory) ->
    $scope.project = {
      name: ""
      description: ""
    }
    
    $scope.lengths = [
      {
        key: 7
        value: '1 week'
      },
      {
        key: 14
        value: '2 weeks'
      },
      {
        key: 21
        value: '3 weeks'
      },
      {
        key: 28
        value: '4 weeks'
      }
    ]

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
        
    $scope.updateSprintLength = () ->
      updateAttribute({sprint_length: $scope.project.sprint_length})

    updateAttribute = (property) ->
      project_id = $scope.project._id.$oid
      Restangular.all('projects').customPUT(property, project_id).then(
        (response) ->
          CookiesFactory.putProject({_id: response._id, name: response.name})
      )
]
