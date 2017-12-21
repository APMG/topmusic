# Topmusic

This application manages voting on songs for a top music poll.

## Set up

This application requres setting up an oauth server and configuring OmniAuth to work with that server.
See https://github.com/omniauth/omniauth. This is a "some assembly required" application. Don't expect to fork it
and have it work without some effort.

Clone and run `bundle install`.

Copy `config/database.example.yml` to `config/database.yml` and modify to taste.

Copy `config/oauth.example.yml` to `config/oauth.yml` and leave alone unless testing oAuth.

Start with `rails s`.

Use the 'developer' auth backend to log in. Navigate to http://localhost:3000/auth/developer and enter some value. You will get redirected to the homepage.

Run `bin/rake db:seed` to prefill the database with example data.

## Importing Songs and fetching album artwork from MusicBrainz.

We have included some rake task scripts that can import lists of songs from a csv file and then search MusicBrainz for artwork.
First you will need to create a new poll.  This will need to be done via the Rails console or database as we didn't get around to making a ui
for this part.  Then set an envirronmental variable for `CSV_FILENAME`  and `POLL_NAME`. (We just used Bash for this). The former is the
complete path and filename for the csv file you want to import and the latter is the slug for the poll you have created. The csv file
should have columns for name, artist and album.  A sample file `list.csv` is included. Then execute `bundle exec rake import:csv`. Once
that runs you can fetch the album ids from MusicBrainz  by calling `bundle exec rake album_art:fetch_mbid`.  The you can download the album art
by running `rake album_art:fetch_album_art`.


## Tests

Topmusic uses Cucumber and RSpec:

```
% bin/cucumber
% bin/rspec
```

You will see a code coverage returned from both. This number is cumulative, so if you run both you get the total.

Additionally, CI will run checks for security and linting. See `.gitlab-ci.yml` for details.

## To test with SSL on a Mac

```
brew install openssl
gem uninstall -a puma
bundle config build.puma --with-opt-dir=/usr/local/opt/openssl
bundle install
bundle exec puma -b 'ssl://127.0.0.1:3000?key=yourkey.pem&cert=yourcert.pem'
```

## To test oAuth integration

It'll probably be easiest to do this on the dev or stage servers.

Presuming you want to get this working locally, follow the directions for testing with OpenSSL on a Mac.

You will need to issue a local certificate. I recommend these instructions: https://jamielinux.com/docs/openssl-certificate-authority/sign-server-and-client-certificates.html

Edit `/etc/hosts` and add an entry for topmusic.dev. Issue and sign a certificate for this domain using the above directions.

You will need to set up Apache to proxy through to your application. Use this vhost config as a template:

```
<VirtualHost *:443>
  ServerAdmin root@localhost
  DocumentRoot /var/www/htdocs
  ServerName topmusic.dev
  ErrorLog /var/log/apache2/topmusic-error_log
  CustomLog /var/log/apache2/topmusic-access_log common

  SSLEngine On
  SSLCertificateFile /Users/[your-username]/Documents/Certs/CA/root/intermediate/certs/topmusic.dev.cert.pem
  SSLCertificateKeyFile /Users/[your-username]/Documents/Certs/CA/root/intermediate/private/topmusic.dev.key.pem
  SSLCACertificateFile /Users/[your-username]/Documents/Certs/CA/root/intermediate/certs/ca-chain.cert.pem
  SSLProxyEngine On
  ProxyPass  /  https://topmusic.dev:3000/

  <Directory "/">
    Options FollowSymLinks
  </Directory>

  LogLevel warn
</VirtualHost>
```

Be sure to change the paths in the SSLCertificate sections to match wherever you set up your CA.

## Theming / Styling

To make each poll have a unique style, we use the poll slug from the database as a basis for a few different pieces.

### CSS

First, we use the poll slug as an HTML class on the the `<html>` element. This slug is prefixed with `brand-`, so if the poll slug is `poll-1` we end up with `<html class="brand-poll-1"`. Currently we are using .scss files in `app/assets/stylesheets/brand` that contain a namespace conforming to a given slug so that default styles can be overridden.

So in the case of a slug of `poll-1`, the SCSS might look like this if we wanted to turn the background purple, the main logo white, and buttons blue:

```
.brand-top89-2017 {
  background: #3a3341;

  .header_logo {
    svg {
      fill: $color-white;
    }
  }

  .btn {
    background-color: #123456;
  }
}
```

The branding CSS only needs to be included at the end so it can override any default styles. This can be done either by an .scss partial included in the main CSS build as the last file(s), or as a separate .css file linked in the html `<head>`. We are currently using the .scss partial route for all themes.

### Poll logos and unique copy

There are a few sections of a poll which need to be markup-based and not just styles. The logo for the name of the poll for example, as well as the explanatory copy that appears at the top of a poll. This is being done by rendering .slim partials with filenames based on the poll slug.

The partials being dynamically pulled in are:

* `partials/svg/poll/logo_<poll-slug>` for the poll logo svg (embedded inline).
* `ballots/callouts/<poll-slug>` for the explanatory copy. This can be any custom html (or slim in this case).

If no partial is present then that element will not appear at all; there are currently no default versions.
