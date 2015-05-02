scrumAid.factory 'DeviseFactory', [
  '$resource', 'CookiesFactory'
  ($resource, CookiesFactory) ->

    # Sign up resource
    signUpResource = $resource '/users.json', {},
      post:
        method: 'POST'
        isArray: false

    # Sign in resource
    signInResource = $resource '/users/sign_in.json', {},
      post:
        method: 'POST'
        isArray: false

    # Sign out resource
    signOutResource = $resource '/users/sign_out.json', {},
      delete:
        method: 'DELETE'
        isArray: false

    # Save signed in user data to cookie
    saveUser = (user) ->
      userToSave = {}
      userToSave._id = user._id
      userToSave.username = user.username
      userToSave.email = user.email
      CookiesFactory.putUser(userToSave)

    # Delete signed out user from cookie
    deleteUser = () ->
      CookiesFactory.deleteUser()

    # Sign up API
    signUp = (user, success, error) ->
      signUpResource.post(user: user).$promise.then(
        (response) ->
          if !response.errors?
            saveUser(response)
            success(currentUser())
          else
            error(response.errors)
        (response) ->
          error(response)
      )

    # Sign in API
    signIn = (user, success, error) ->
      signInResource.post(user:user).$promise.then(
        (response) ->
          if !response.error?
            saveUser(response)
            success(currentUser())
          else
            error(response.error)
        (reponse) ->
          error(response)
      )

    # Sign out API
    signOut = (success, error) ->
      signOutResource.delete().$promise.then(
        (response) ->
          deleteUser()
          success()
        (response) ->
          error(response)
      )
    # Current user API
    currentUser = () ->
      CookiesFactory.getUser()

    # Is authenticated API
    isAuthenticated = () ->
      !!CookiesFactory.getUser()


    # API return
    {
      signUp: signUp
      signIn: signIn
      signOut: signOut
      currentUser: currentUser
      isAuthenticated: isAuthenticated
    }
]
