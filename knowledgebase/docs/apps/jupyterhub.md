# <img src="/documentation/img/jupyterhub-logo.png" width="25px"> JupyterHub App

## Selecting a notebook image

By default, the app uses the `jupyter/datascience-notebook`. The upstream Jupyterhub project
maintains many other [notebook images](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html).

To use a different notebook image, use the [Web terminal](/documentation//documentation/apps#web-terminal)
to place custom configuration under `/app/data/customconfig.py`. For example,
add a line like below:

```
c.DockerSpawner.container_image = 'jupyter/all-spark-notebook:77e10160c7ef'
```

It is also possible to use any arbitrary docker image built from the `jupyter/base-notebook`.
For this, build an image from Dockerfile with `FROM jupyter/base-notebook`, push it to Dockerhub
and update the image field above.

To apply the configuration, restart the app using the Restart button.

## Notebook Memory limit

By default, notebooks are given 500M (including swap). This can be changed by editing `/app/data/customconfig.py`.

```
c.Spawner.mem_limit = '1G'
```

To apply the configuration, restart the app using the Restart button.

## Other custom configuration

Use the [Web terminal](/documentation//documentation/apps#web-terminal)
to place custom configuration under `/app/data/customconfig.py`.

See the [docs](https://github.com/jupyterhub/jupyterhub-deploy-docker#run-jupyterhub) for
more information.


