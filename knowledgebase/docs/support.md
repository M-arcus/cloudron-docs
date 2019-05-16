# Support

## Forum

The <a href="https://forum.cloudron.io">Forum</a> is the best place to ask support
questions. The Forum makes reported issues SEO friendly and helps others (and you)
find resolutions to existing problems.

## Email

For support related enquiries, please write to <a target="_blank" href="mailto:support@cloudron.io">support@cloudron.io</a>.

For sales related enquiries, please write to <a target="_blank" href="mailto:sales@cloudron.io">sales@cloudron.io</a>.

## Remote Support

To enable SSH access to your server for the Cloudron support team, use the `Enable SSH support access`
button in the `Support` view.

<center>
<img src="/documentation/img/remote-support.png" class="shadow" width="500px">
</center>

## SSH Keys

You can also add the following SSH keys manually. Depending on your setup, the keys below can be added
to one of the following files: `/root/.ssh/authorized_keys` OR `/home/ubuntu/.ssh/authorized_keys`.

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQVilclYAIu+ioDp/sgzzFz6YU0hPcRYY7ze/LiF/lC7uQqK062O54BFXTvQ3ehtFZCx3bNckjlT2e6gB8Qq07OM66De4/S/g+HJW4TReY2ppSPMVNag0TNGxDzVH8pPHOysAm33LqT2b6L/wEXwC6zWFXhOhHjcMqXvi8Ejaj20H1HVVcf/j8qs5Thkp9nAaFTgQTPu8pgwD8wDeYX1hc9d0PYGesTADvo6HF4hLEoEnefLw7PaStEbzk2fD3j7/g5r5HcgQQXBe74xYZ/1gWOX2pFNuRYOBSEIrNfJEjFJsqk3NR1+ZoMGK7j+AZBR4k0xbrmncQLcQzl6MMDzkp support@cloudron.io
```

!!! note "Keep the key to a single line"
    SSH key must be added as a single line. Make sure it doesn't break across multiple lines.

## Diagnostics

If the Cloudron dashboard is unreachable, it can be difficult to diagnose what is wrong.
You can SSH into your server and run the following script when contacting the Cloudron team.

This script collects some diagnostic information on the server and enables SSH support when given `--enable-ssh`
```
sudo cloudron-support [--enable-ssh]
```

Older versions of Cloudron may not have this script yet. In such a situation it can be run as follows:
```
wget https://git.cloudron.io/cloudron/box/raw/master/scripts/cloudron-support
chmod +x cloudron-support
sudo ./cloudron-support
```

