# <img src="/documentation/img/collabora-logo.png" width="25px"> Collabora App

## Setup

The Collabora App can be used to provide rich document editing functionality for
files hosting inside [NextCloud](/documentation/apps/nextcloud).

* Install [NextCloud](https://cloudron.io/store/com.nextcloud.cloudronapp.html) from
  the App Store. For this example, we assume NextCloud was installed at `nextcloud.smartserver.space`.

* Install [Collabora](/store/com.collaboraoffice.coudronapp.html) from the App Store

* In the Collabora setup UI, provide the domain of the NextCloud installation.

    <img src="/documentation/img/collabora-settings.png" class="shadow">

* Enable the `Collabora Online` app in NextCloud. This app is under the `Office & text`
  category in the NextCloud app store. Once installed, go to NextCloud `Settings` and
  select the `Collabora Office` item on the left pane. Enter the domain of the collabora
  installation.

    <img src="/documentation/img/nextcloud-collabora.png" class="shadow">

* You should now be able to view and edit rich text documents right inside NextCloud.

    <img src="/documentation/img/nextcloud-collabora-editor.png" class="shadow">
