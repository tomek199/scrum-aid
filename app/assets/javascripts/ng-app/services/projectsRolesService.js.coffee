scrumAid.service 'ProjectsRolesService', [
  '$resource'
  ($resource) ->
    $resource '/projects/:project_id/roles/:role_id/:action', {},
      index:
        method: 'GET'
        isArray: true
      create:
        method: 'POST'
        isArray: false
      update:
        method: 'PUT'
        isArray: false
      delete:
        method: 'DELETE'
        isArray: false
      markAsDefault:
        method: 'POST'
        params:
          action: 'mark_as_default'
        isArray: true
]
