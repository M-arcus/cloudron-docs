# Notifications

## Email Notifications

The Cloudron will notify the Cloudron administrator via email if apps go down, run out of memory,
low disk space, have updates available etc.

The Cloudron administrators will receive a weekly digest email about all the activities on
the Cloudron. At the time of this writing, the email sends out information about pending and
applied updates.

## Health check monitor

You will have to setup a 3rd party service like [Cloud Watch](https://aws.amazon.com/cloudwatch/) or
[UptimeRobot](http://uptimerobot.com/) to monitor the Cloudron itself. You can use
`https://my.<domain>/api/v1/cloudron/status` as the health check URL.

