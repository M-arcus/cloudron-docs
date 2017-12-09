# Support

!!! warning "We only offer support for Cloudrons with a valid subscription. See our [pricing](/pricing.html) if you haven't signed up for one yet."

If you have issues with any app, please check the corresponding app section on this page, for platform issues look into the knowledge base here and use the search field on the top right.

There is also have an issue tracker for platform related problems and feature requests [here](https://git.cloudron.io/cloudron/box/issues). Use the search to find existing issues and possible solutions.

## Contact

If you haven't found any solution to your problem, head over to our [chat](https://chat.cloudron.io) or use the live-chat box on the bottom right at https://cloudron.io/.

You may also send us an email with as much information as possible to [support@cloudron.io](mailto:support@cloudron.io).

## SSH Support

For Cloudrons on a **Startup** or **Enterprise** subscription (see [pricing](/pricing.html)), we offer to fix issues directly on your instance.

Head to your Cloudron's webinterface and go to the **Support** view. At the bottom of the page you can give us temporary SSH access.

!!! warning "Before doing so, contact us first via [email](mailto:support@cloudron.io) or [chat](https://chat.cloudron.io)"

<img src="/img/support-ssh.png" class="shadow">

## Changing Cloudron.io Account email

The email of the Cloudron.io account cannot be changed. We recommend creating another Cloudron.io
account with the desired email id instead.

First unlink the Cloudron.io account. To do so, run the following command on the Cloudron:

```
    mysql -uroot -ppassword -e "DELETE FROM box.settings WHERE name='appstore_config';"
```

Next, navigate to the `App store` view on the Cloudron and register a new account or login
with another existing account.

