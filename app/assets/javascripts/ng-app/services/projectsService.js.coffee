scrumAid.service 'ProjectsService', ($resource) ->
  $resource '/projects/:action/:id', {},
    index:
      method: 'GET'
      params: action: ''
      isArray: true