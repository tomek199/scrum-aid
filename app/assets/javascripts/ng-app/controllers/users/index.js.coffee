scrumAid.controller 'UsersIndexCtrl', [
  '$scope', '$location', '$routeParams', '$modal', 'CookiesFactory', 'ProjectsService', 'ProjectsUsersService', 'ProjectsRolesService'
  ($scope, $location, $routeParams, $modal, CookiesFactory, ProjectsService, ProjectsUsersService, ProjectsRolesService) ->

    ProjectsService.show(id: $routeParams.id).$promise.then(
      (response) ->
        $scope.project = response
        CookiesFactory.putProject({_id: response._id, name: response.name})
      (error) ->
        console.log error
    )

    ProjectsUsersService.index(project_id: $routeParams.id).$promise.then(
      (response) ->
        $scope.users = response
      (error) ->
        console.log error
    )

    ProjectsRolesService.index(project_id: $routeParams.id).$promise.then(
      (response) ->
        $scope.roles = response
      (error) ->
        console.log error
    )

    $scope.addUsers = () ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-addUserToProject.html'
        controller: 'UsersAddToProjectCtrl'
        size: 'md'
        resolve:
          project_id: ->
            $scope.project._id.$oid
      modalInstance.result.then (result) ->
        if result._id?
          $scope.users.push(result)
        else
          console.log(result)

    $scope.delete = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        project_id = $scope.project._id.$oid
        user_id = $scope.users[index]._id.$oid
        ProjectsUsersService.removeFromProject(project_id: project_id, user_id: user_id).$promise.then(
          (response) ->
            $scope.users.splice(index, 1)
          (error) ->
        )

    $scope.addRole = () ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-role.html'
        controller: 'RolesCreateCtrl'
        size: 'md'
        resolve:
          project_id: ->
            $scope.project._id.$oid
      modalInstance.result.then (result) ->
        if result._id?
          $scope.roles.push(result)
        else
          console.log(result)

    $scope.isCurrentUser = (index) ->
      if $scope.users[index]._id.$oid == CookiesFactory.getUser()._id.$oid
        return true
      false

    $scope.isOwner = (index) ->
      if $scope.users[index]._id.$oid == $scope.project.owner_id.$oid
        return true
      false

    $scope.changeOwner = (index) ->
      user = $scope.users[index]
      properties = {owner_id: user._id.$oid, owner_username: user.username}
      project_id = $routeParams.id
      ProjectsService.update(id: project_id, properties).$promise.then(
        (response) ->
          $scope.project = response
        (error) ->
          console.log error
      )

]
