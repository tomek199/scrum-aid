scrumAid.service 'ProjectsService', [
  '$resource'
  ($resource) ->
    $resource '/projects/:id', {},
      index:
        method: 'GET'
        isArray: true
      show:
        method: 'GET'
        isArray: false
      create:
        method: 'POST'
        isArray: false
      update:
        method: 'PUT'
        isArray: false
      delete:
        method: 'DELETE'
        isArray: false
]
