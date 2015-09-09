scrumAid.controller 'SprintsIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'ProjectsService'
  ($scope, $routeParams, $modal, ProjectsService) ->
    ProjectsService.show(id: $routeParams.id).$promise.then(
      (response) ->
        $scope.project = response
      (error) ->
        console.log error
    )

    $scope.new = () ->
      modalInstance = $modal.open
        templateUrl: 'sprints/add.html'
        controller: 'SprintsCreateCtrl'
        size: 'lg'
      modalInstance.result.then (result) ->
        if result._id?
#          todo
        else
          console.log(result)
]
