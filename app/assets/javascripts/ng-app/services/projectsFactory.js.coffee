scrumAid.service 'ProjectsFactory', ($resource) ->
  $resource 'projects/:action/:id', {},
    index:
      method: 'GET'
      params: action: 'index'