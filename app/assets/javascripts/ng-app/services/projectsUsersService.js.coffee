scrumAid.service 'ProjectsUsersService', [
  '$resource'
  ($resource) ->
    $resource '/projects/:project_id/users/:id/:action', {},
      index:
        method: 'GET'
        isArray: true
      toAdd:
        method: 'GET'
        params:
          action: 'to_add'
        isArray: true

]
