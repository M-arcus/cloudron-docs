# <img src="/documentation/img/gitlab-logo.png" width="25px"> GitLab App

## Custom gitlab.yml

GitLab is customized using GitLab's admin interface. Some options can ony be
changed in `gitlab.yml`. For such situations, use the [Web terminal's](/documentation/apps#web-terminal)
and create a file named `/app/data/gitlab.yml`. This way custom configurations
will be preserved across updates and will also be backed up.

For example, to add GitHub login and Piwik analytics, add a `/app/data/gitlab.yml` like below
and _restart_ the application:

```
production:
  <<: *base
  extra:
    ## Piwik analytics.
    piwik_url: 'analytics.example.com'
    piwik_site_id: '7'

  omniauth:
    # Allow login via Twitter, Google, etc. using OmniAuth providers
    enabled: true
    allow_single_sign_on: ["github"]
    block_auto_created_users: false
    external_providers: [ ]
    providers:
      - { name: 'github',
          app_id: 'my_app_id',
          app_secret: 'my_app_secret',
          url: "https://github.com/",
          verify_ssl: true,
          args: { scope: 'user:email' } }

```

## Disabling registration

By default, GitLab allows external people to sign up. This can be disabled to
restrict use only to Cloudron users as follows:

GitLab > Admin area > Settings > Features > remove the check mark "Sign-up enabled"

## GitLab Runner for CI

[GitLab CI](https://docs.gitlab.com/ce/ci/README.html) involves installing one or more GitLab Runners.
These runners carry out tasks as instructed by the main GitLab installation. When installing a runner,
you have to select the [project tags](https://docs.gitlab.com/ce/ci/runners/#using-tags) to
which the runner will respond and the type of tasks ("[executor](https://docs.gitlab.com/runner/executors/README.html)")
it can carry out. For example, there is a Shell executor, Docker execuctor etc.

Once GitLab runner is installed, you have to add the runner in GitLab. When adding the
runner in GitLab, you can decide how GitLab [schedules tasks](https://docs.gitlab.com/ce/ci/runners/)
in the runner ie. if the runner is exclusive to a project ('Specific Runner') or shared between
projects ('Shared Runner) or specific to a group ('Group Runner').

Cloudron's GitLab package can be used with GitLab Runner as follows.

* First create a **new** server and install GitLab Runner on it following the instructions
  at [GitLab docs](https://docs.gitlab.com/runner/install/linux-repository.html). In short:

```
    # For ubuntu
    curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
    sudo apt-get install gitlab-runner
```

* Get the token listed in GitLab under `https://<gitlab.example.com>/admin/runners` (under shared runners section).

* [Register the runner](https://docs.gitlab.com/runner/register/index.html) with the token from the above step

```
    root@localhost:~# sudo gitlab-runner register
    Running in system-mode.                            
                                                           
    Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
    https://gitlab.cloudron.xyz
    Please enter the gitlab-ci token for this runner:
    xzdZgdsXq5uSFCyAK7pP
    Please enter the gitlab-ci description for this runner:
    [localhost]: Shell Jobs Runner
    Please enter the gitlab-ci tags for this runner (comma separated):

    Whether to lock the Runner to current project [true/false]:
    [true]: false
    Registering runner... succeeded                     runner=xzdZgdsX
    Please enter the executor: docker, docker-ssh, shell, ssh, virtualbox, docker-ssh+machine, parallels, docker+machine, kubernetes:
    shell
    Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded! 
```

* The Runner should now be listed under `https://<gitlab.example.com>/admin/runners`.

* Now push a [.gitlab-ci.yml](https://docs.gitlab.com/ce/ci/yaml/README.html) to your project to
  start using the runner.


## Reset Admin Password  

To reset the admin password, run the following commands using the [Web terminal](/documentation/apps#web-terminal):

```
    su - git  
    cd gitlab  
    bundle exec rails c production # (takes about 10 sec to bring up rails terminal)
    user = User.where(id: 1).first  
    user.password = 'NEW_PASS'  
    user.password_confirmation = 'NEW_PASS'  
    user.save  
    exit  
```

