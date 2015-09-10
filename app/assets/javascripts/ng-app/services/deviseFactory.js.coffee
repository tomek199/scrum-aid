scrumAid.factory 'DeviseFactory', [
  'Restangular', 'CookiesFactory'
  (Restangular, CookiesFactory) ->

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
      Restangular.oneUrl('users.json').post('', user: user).then(
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
      Restangular.oneUrl('users/sign_in.json').post('', user: user).then(
        (response) ->
          if !response.error?
            saveUser(response)
            success(currentUser())
          else
            error(response.error)
        (response) ->
          error(response)
      )

    # Sign out API
    signOut = (success, error) ->
      Restangular.oneUrl('/users/sign_out.json').remove().then(
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
