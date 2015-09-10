scrumAid.controller 'ProjectsIndexCtrl', [
  '$scope','$location', '$modal', 'Restangular', 'CookiesFactory'
  ($scope, $location, $modal, Restangular, CookiesFactory) ->
    Restangular.all('projects').getList().then(
      (response) ->
        $scope.projects = response
    )

    $scope.new = () ->
      modalInstance = $modal.open
        templateUrl: 'projects/add.html'
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
        Restangular.one('projects', project_id).remove().then(
          (response) ->
            CookiesFactory.deleteProject(project_id)
            $scope.projects.splice(index, 1)
        )

    $scope.projectShow = (index) ->
      id = $scope.projects[index]._id.$oid
      $location.path '/projects/' + id
]
