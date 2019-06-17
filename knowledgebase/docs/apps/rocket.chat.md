# <img src="/documentation/img/rocketchat-logo.png" width="25px"> Rocket.Chat App

## Mobile Clients

Rocket.Chat [mobile clients](https://rocket.chat/download) are available for most mobile platforms:

* [Play Store](https://play.google.com/store/apps/details?id=chat.rocket.android)
* [Apple App Store](https://itunes.apple.com/app/rocket-chat/id1148741252)

## Webhook Integrations

Webhook Integrations can be added in the Administration panel under `Integrations`.
Rocket.Chat supports notifications from and to other apps or services through its webhook integrations.
Incoming notifications require a message body parsing code snippet, which transforms the incoming webhook to a readable message,
which will be posted into a selected chat channel.

### GitLab

Create a new `Incoming WebHook Integration` and configure the destination channel and user, then enalbe a custom sript.
GitLab supports multiple types of webhook notifications and thus requires a more sophisticated transform script.
The below works for issue, comment, merge request, push and tag events:

```javascript
/*jshint  esnext:true*/
// see https://gitlab.com/help/web_hooks/web_hooks for full json posted by GitLab
const NOTIF_COLOR = '#6498CC';

class Script {
    process_incoming_request({
        request
    }) {
        try {
            switch (request.headers['x-gitlab-event']) {
                case 'Push Hook':
                    return this.pushEvent(request.content);
                case 'Merge Request Hook':
                    return this.mergeRequestEvents(request.content);
                case 'Note Hook':
                    return this.commentEvent(request.content);
                case 'Issue Hook':
                    return this.issueEvent(request.content);
                case 'Tag Push Hook':
                    return this.tagEvent(request.content);
            }
        } catch (e) {
            console.log('gitlabevent error', e);
            return {
                error: {
                    success: false,
                    message: e.message || e
                }
            };
        }
    }

    issueEvent(data) {
        return {
            content: {
                username: data.user.name,
                text: `${data.user.username} ${data.object_attributes.state} an issue _${data.object_attributes.title}_ on ${data.project.name}. *Description:* ${data.object_attributes.description}. See: ${data.object_attributes.url}`,
                icon_url: data.user.avatar_url
            }
        };
    }

    commentEvent(data) {
        const comment = data.object_attributes;
        const user = data.user;
        let text;
        if (data.merge_request) {
            let mr = data.merge_request;
            text = `${user.name} commented on Merge Request #${mr.id} [${mr.title}](${comment.url})`;

        } else if (data.commit) {
            let commit = data.commit;
            let message = commit.message.replace(/\n[^\s\S]+/, '...').replace(/\n$/, '');
            text = `${user.name} commented on commit [${commit.id.slice(0, 8)} ${message}](${comment.url})`;
        } else if (data.issue) {
            let issue = data.issue;
            text = `${user.name} commented on issue [#${issue.id} ${issue.title}](${comment.url})`;
        } else if (data.snippet) {
            let snippet = data.snippet;
            text = `${user.name} commented on code snippet [#${snippet.id} ${snippet.title}](${comment.url})`;
        }
        return {
            content: {
                username: 'gitlab/' + data.project.name,
                icon_url: data.project.avatar_url || user.avatar_url || '',
                text,
                attachments: [{
                    text: comment.note,
                    color: NOTIF_COLOR
                }]
            }
        };
    }

    mergeRequestEvent(data) {
        const user = data.user;
        const mr = data.object_attributes;
        return {
            content: {
                username: `gitlab/${mr.target.name}`,
                icon_url: mr.target.avatar_url || mr.source.avatar_url || user.avatar_url || '',
                attachments: [{
                    title: `${user.name} ${mr.action} Merge Request #${mr.id} ${mr.title}`,
                    title_link: mr.url,
                    text: `_${mr.source_branch} into ${mr.target_branch}_`,
                    color: NOTIF_COLOR
                }]
            }
        };
    }

    pushEvent(data) {
        const project = data.project;
        return {
            content: {
                username: `gitlab/${project.name}`,
                text: `![${data.user_name}](${data.user_avatar}) ${data.user_name} pushed ${data.total_commits_count} commits to ${project.name}. See: ${project.web_url}`,
                icon_url: project.avatar_url || data.user_avatar || '',
                attachments: [{
                    title: data.total_commits_count + ' Commits',
                    title_link: project.web_url,
                    text: data.commits.map((commit) => `  - ${new Date(commit.timestamp).toUTCString()} [${commit.id.slice(0, 8)}](${commit.url}) by ${commit.author.name}: ${commit.message.replace(/\s*$/, '')}`).join('\n'),
                    color: NOTIF_COLOR
                }]
            }
        };
    }

    tagEvent(data) {
        let tag = data.ref.replace(/^.*?([^\/]+)$/, '$1');
        return {
            content: {
                username: `gitlab/${data.project.name}`,
                icon_url: data.project.avatar_url || data.user_avatar || '',
                text: `${data.user_name} push tag [${tag} ${data.checkout_sha.slice(0, 8)}](${data.project.web_url}/tags/${tag})`
            }
        };
    }

}
```

After the integration is setup, the Webhook URL and Secret Token is generated and can now be setup with the project in GitLab at `Settings` -> `Integrations`.

!!! warning "Webhook test"
    Triggering a test webhook from GitLab will likely result in an error, since the above transform script expects a body, which is not provided from GitLab while running a test call. A test has to be made with a real action on the repo.

## Live Chat

Rocket.Chat has a live chat feature that allows you to embed a chat widget into your website.

Head over to Rocket.Chat app's Administration view, select the Livechat section and enable it. After this, you will find a `Livechat` entry in the side bar.

<center>
<img src="/blog/img/live-chat-4.png" class="shadow" width="30%">
<img src="/blog/img/live-chat-2.png" class="shadow" width="30%">
<img src="/blog/img/live-chat-3.png" class="shadow" width="30%">
</center>
<br/>

*You will also find options to customize the live chat widget appearance to match your look and feel there.*

Then copy the Javascript code snippet shown in the Livechat Installation view and paste it to the bottom of your website's html code as the last thing before the `</body>` tag. WordPress users can use the [Rocket.Chat LiveChat WordPress plugin](https://wordpress.org/plugins/rocketchat-livechat/) instead.

You will now see the live chat widget on the bottom right of your page.
