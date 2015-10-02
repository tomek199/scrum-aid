scrumAid.controller 'UsersIndexCtrl', [
  '$scope', '$routeParams', '$modal', 'CookiesFactory', 'Restangular'
  ($scope, $routeParams, $modal, CookiesFactory, Restangular) ->

    project = Restangular.one('projects', $routeParams.project_id)

    project.get().then(
      (response) ->
        $scope.project = response
        CookiesFactory.putProject({_id: response._id, name: response.name})
    )

    project.getList('users').then(
      (response) ->
        $scope.users = response
    )

    project.getList('roles').then(
      (response) ->
        $scope.roles = response
      (error) ->
        console.log error
    )

    $scope.addUsers = () ->
      modalInstance = $modal.open
        templateUrl: 'users/addUserToProject.html'
        controller: 'UsersAddToProjectCtrl'
        size: 'md'
        resolve:
          project_id: ->
            $scope.project._id.$oid
          roles: ->
            roles = []
            for role in $scope.roles
              if role.editable
                roles.push role
            return roles
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
        project.one('users', user_id).customDELETE('remove_from_project').then(
          (response) ->
            $scope.users.splice(index, 1)
        )

    $scope.addRole = () ->
      modalInstance = $modal.open
        templateUrl: 'roles/add.html'
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

    $scope.deleteRole = (index) ->
      modalInstance = $modal.open
        templateUrl: 'directives/scModal-delete.html'
      modalInstance.result.then (result) ->
        project_id = $scope.project._id.$oid
        role_id = $scope.roles[index]._id.$oid
        project.one('roles', role_id).remove().then(
          (response) ->
            $scope.roles.splice(index, 1)
          (error) ->
        )

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
      project_id = $routeParams.project_id
      project.customPUT(properties).then(
        (response) ->
          $scope.project = response
      )

    $scope.markAsDefault = (index) ->
      role = $scope.roles[index]
      project_id = $routeParams.project_id
      project.one('roles', role._id.$oid).customPOST('', 'mark_as_default').then(
        (response) ->
          $scope.roles = response
      )

    $scope.updateRole = (index) ->
      role = $scope.roles[index]
      modalInstance = $modal.open
        templateUrl: 'roles/update.html'
        controller: 'RolesUpdateCtrl'
        size: 'md'
        resolve:
          project_id: ->
            $scope.project._id.$oid
          role: ->
            role

      modalInstance.result.then (result) ->
        if result._id?
          $scope.roles[index] = result
        else
          console.log(result)

]
