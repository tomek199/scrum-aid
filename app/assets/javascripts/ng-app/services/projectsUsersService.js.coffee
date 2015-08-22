scrumAid.service 'ProjectsUsersService', [
  '$resource'
  ($resource) ->
    $resource '/projects/:project_id/users/:user_id/:action', {},
      index:
        method: 'GET'
        isArray: true
      toAdd:
        method: 'GET'
        params:
          action: 'to_add'
        isArray: true
      addToProject:
        method: 'POST'
        params:
          action: 'add_to_project'
        isArray: false
      removeFromProject:
        method: 'DELETE'
        params:
          action: 'remove_from_project'
        isArray: false
]
