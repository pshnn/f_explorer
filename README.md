# FExplorer

This is a simple application showing off wrapper around Dropbox API.

## Setup

#### Pre-requirements

  - RVM
  - Dropbox account

First of all you need to clone the project:

```sh
$ git clone https://github.com/pshnn481/f_explorer.git
$ cd f_explorer
```

Install gems:

```sh
$ bundle install
```

Create .env file or just copy .env.example file:

```sh
$ cp .env.example .env
```

#### Dropbox Public folders
Public folders [was disabled](https://www.dropbox.com/help/files-folders/public-folder) for all users since September 1, 2017.
To be able to work with your Dropbox storage you need to complete several steps:

- Log In into your Dropbox account
- Create connected app in [developers section](https://www.dropbox.com/developers)
- Obtain OAuth2 access token
(*Developers section > My apps > [Your App Name] > Generated access token*)

Now when you have OAuth2 token you can paste it into your .env file under `DROPBOX_OAUTH_BEARER` key.

So your .env file should look like this:
```sh
DROPBOX_OAUTH_BEARER='your_OAuth2_token'
```

Now run Rails server:
```sh
$ rails server
```

Application will be running on `localhost:3000`
