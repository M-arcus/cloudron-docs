# App Store

## App Store Account

Cloudron App Store account is identified by an email. Each Cloudron is identified by a unique Cloudron ID. You can
view this information in the `Settings` page.

<br/>

<center>
<img src="../img/cloudron-account.png" class="shadow" width="600px">
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

