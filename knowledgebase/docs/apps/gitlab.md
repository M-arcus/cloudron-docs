# <img src="/documentation/img/gitlab-logo.png" width="25px"> GitLab App

## Custom gitlab.yml

GitLab is customized using GitLab's admin interface. Some options can ony be
changed in `gitlab.yml`. For such situations, use the [Web terminal's](/documentation/apps/#web-terminal)
and create a file named `/app/data/gitlab.yml`. This way custom configurations
will be preserved across updates and will also be backed up.

## Disabling registration

By default, GitLab allows external people to sign up. This can be disabled to
restrict use only to Cloudron users as follows:

GitLab > Admin area > Settings > Features > remove the check mark "Sign-up enabled"

