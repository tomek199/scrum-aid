scrumAid.factory 'CookiesFactory', [
  '$cookies'
  ($cookies) ->

    getUser = () ->
      user = $cookies.currentUser
      if user != undefined && user.length > 0
        return JSON.parse($cookies.currentUser)
      else
        return null

    putUser = (user) ->
      $cookies.currentUser = JSON.stringify(user)

    deleteUser = () ->
      $cookies.currentUser = ""

    getProject = () ->
      project = $cookies.currentProject
      if project != undefined && project.length > 0
        return JSON.parse($cookies.currentProject)
      else
        return null

    putProject = (project) ->
      $cookies.currentProject = JSON.stringify(project)

    deleteProject = (id) ->
      if id
        project = $cookies.currentProject
        if project != undefined && project.length > 0
          if JSON.parse(project)._id.$oid == id
            $cookies.currentProject = ""
      else
        $cookies.currentProject = ""

    {
      getUser: getUser
      putUser: putUser
      deleteUser: deleteUser
      getProject: getProject
      putProject: putProject
      deleteProject: deleteProject
    }
]