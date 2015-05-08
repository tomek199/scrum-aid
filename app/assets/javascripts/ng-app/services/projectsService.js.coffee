scrumAid.service 'ProjectsService', [
  '$resource'
  ($resource) ->
    $resource '/projects/:action/:id', {},
      index:
        method: 'GET'
        params: action: ''
        isArray: true
      create:
        method: 'POST'
        params: action: ''
        isArray: false
      delete:
        method: 'DELETE'
        params: action: ''
]
