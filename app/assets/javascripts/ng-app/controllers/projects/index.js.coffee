scrumAid.controller 'ProjectsIndexCtrl', [
  '$scope','$location', '$modal', 'ProjectsService', 'CookiesFactory'
  ($scope, $location, $modal, ProjectsService, CookiesFactory) ->
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
      modalInstance.result.then (result) ->
        if result._id?
          $scope.projects.push(result)
        else
          console.log(result)

    $scope.delete = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        project_id = $scope.projects[index]._id.$oid
        ProjectsService.delete(id: project_id).$promise.then(
          (response) ->
            CookiesFactory.deleteProject(project_id)
            $scope.projects.splice(index, 1)
          (error) ->
        )

    $scope.projectShow = (index) ->
      id = $scope.projects[index]._id.$oid
      $location.path '/projects/' + id
]
