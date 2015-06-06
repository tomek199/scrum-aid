scrumAid.service 'ProjectsUsersService', [
  '$resource'
  ($resource) ->
    $resource '/projects/:project_id/users/:id', {},
      index:
        method: 'GET'
        isArray: true
]
