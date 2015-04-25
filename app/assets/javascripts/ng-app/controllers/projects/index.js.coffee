scrumAid.controller 'ProjectsIndexCtrl', [
  '$scope', '$modal', 'ProjectsService'
  ($scope, $modal, ProjectsService) ->
    ProjectsService.index().$promise.then(
      (response) ->
        $scope.projects = response
      (error) ->
        console.log error
    )

    $scope.new = () ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-project.html'
        controller: 'ProjectsCreateCtrl'
        size: 'lg'

      modalInstance.result.then (result)->
        if result._id?
          $scope.projects.push(result)
        else
          console.log(result)
]
