# App Store

## Overview

The Cloudron App Store is a repository of apps hosted at cloudron.io. The App Store
provides app packages that can be installed on a Cloudron. A Cloudron installation
periodically polls the App Store for updates.

## App Store Account

A Cloudron App Store account is used to manage your subscription & billing. Before installing
apps, you must set up the Cloudron with your App Store Account information. By doing so, the
Cloudron will register itself and get an unique Cloudron ID.

You can view this information in the `Settings` page.

<br/>

<center>
<img src="/documentation/img/cloudron-account.png" class="shadow" width="500px">
</center>

## App Store Password reset

The password of the App Store account can be reset <a href="https://cloudron.io/passwordreset.html" target="_blank">here</a>.

## Changing App Store account

The email associated with a existing Cloudron.io account cannot be changed. To use another Cloudron.io account,
do the following:

* Unlink the existing Cloudron.io account on your Cloudron. To do so, run the following command on the Cloudron:

    ```
        mysql -uroot -ppassword -e "DELETE FROM box.settings WHERE name='appstore_config';"
    ```

* Navigate to the `App store` view on the Cloudron and register a new account or login
with another existing account.

