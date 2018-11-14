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

!!! note "Remove existing notebook containers"
    For the memory limit to take effect, you have to remove any existing docker notebook containers
    using the `/app/code/remove_notebook_containers.py` script. Notebook data will be intact despite
    deleting the container.

## Notebook persistence

All notebooks are part of the application backup and persisted across updates.

Libraries installed using `conda` are not part of the backup and are part of the notebook container.
Idle notebooks are shutdown over time but they are not destroyed. This means that if any libraries
installed in notebook container will generally persist.

If the notebook image is changed, the old notebook containers are destroyed. This means that
any libraries that were previously installed have to be re-installed.

## Other custom configuration

Use the [Web terminal](/documentation//documentation/apps#web-terminal)
to place custom configuration under `/app/data/customconfig.py`.

See the [docs](https://github.com/jupyterhub/jupyterhub-deploy-docker#run-jupyterhub) for
more information.


