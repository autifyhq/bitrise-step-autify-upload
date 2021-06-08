[bitrise-test-check badge]: https://github.com/autifyhq/bitrise-step-autify-upload/actions/workflows/bitrise-test-step.yml/badge.svg
[bitrise-test-check url]:   https://github.com/autifyhq/bitrise-step-autify-upload/actions/workflows/bitrise-test-step.yml

[bitrise-audit-check badge]: https://github.com/autifyhq/bitrise-step-autify-upload/actions/workflows/bitrise-audit-step.yml/badge.svg
[bitrise-audit-check url]:   https://github.com/autifyhq/bitrise-step-autify-upload/actions/workflows/bitrise-audit-step.yml

# Autify Upload &middot; [![bitrise-test-check][bitrise-test-check badge]][bitrise-test-check url] [![bitrise-audit-check][bitrise-audit-check badge]][bitrise-audit-check url]

Upload the app file for iOS to Autify.

## How to use this Step

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*

Step by step:

1. Open up your Terminal / Command Line
1. `git clone` the repository
1. `cd` into the directory of the step (the one you just `git clone`d)
1. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`
   (the `.bitrise.secrets.yml` is a git ignored file, you can store your secrets in it)
1. Check the `bitrise.yml` file for any secret you should set in `.bitrise.secrets.yml`
    * Best practice is to mark these options with something like `# define these in your .bitrise.secrets.yml`, in the `app:envs` section.
1. Once you have all the required secret parameters in your `.bitrise.secrets.yml` you can just run this step with the [bitrise CLI](https://github.com/bitrise-io/bitrise): `bitrise run test`

An example `.bitrise.secrets.yml` file:

```bash
envs:
- upload_token: Autify Personal Access Token
- project_id: Autify Project ID
- app_dir_path: app directory path
```

## How to create your own step

1. Create a new git repository for your step (**don't fork** the *step template*, create a *new* repository)
1. Copy the [step template](https://github.com/bitrise-steplib/step-template) files into your repository
1. Fill the `step.sh` with your functionality
1. Wire out your inputs to `step.yml` (`inputs` section)
1. Fill out the other parts of the `step.yml` too
1. Provide test values for the inputs in the `bitrise.yml`
1. Run your step with `bitrise run test` - if it works, you're ready

__For Step development guidelines & best practices__ check this documentation: [https://github.com/bitrise-io/bitrise/blob/master/_docs/step-development-guideline.md](https://github.com/bitrise-io/bitrise/blob/master/_docs/step-development-guideline.md).

**NOTE:**

If you want to use your step in your project's `bitrise.yml`:

1. git push the step into it's repository
1. reference it in your `bitrise.yml` with the `git::PUBLIC-GIT-CLONE-URL@BRANCH` step reference style:

```yaml
- git::https://github.com/user/my-step.git@branch:
   title: My step
   inputs:
   - my_input_1: "my value 1"
   - my_input_2: "my value 2"
```

You can find more examples of step reference styles
in the [bitrise CLI repository](https://github.com/bitrise-io/bitrise/blob/master/_examples/tutorials/steps-and-workflows/bitrise.yml#L65).

## How to contribute to this Step

1. Fork this repository
1. `git clone` it
1. Create a branch you'll work on
1. To use/test the step just follow the **How to use this Step** section
1. Do the changes you want to
1. Run/test the step before sending your contribution
    * You can also test the step in your `bitrise` project, either on your Mac or on [bitrise.io](https://www.bitrise.io)
    * You just have to replace the step ID in your project's `bitrise.yml` with either a relative path, or with a git URL format
    * (relative) path format: instead of `- original-step-id:` use `- path::./relative/path/of/script/on/your/Mac:`
    * direct git URL format: instead of `- original-step-id:` use `- git::https://github.com/user/step.git@branch:`
    * You can find more example of alternative step referencing at: https://github.com/bitrise-io/bitrise/blob/master/_examples/tutorials/steps-and-workflows/bitrise.yml
1. Once you're done just commit your changes & create a Pull Request

## Share your own Step

You can share your Step or step version with the [bitrise CLI](https://github.com/bitrise-io/bitrise). If you use the `bitrise.yml` included in this repository, all you have to do is:

1. In your Terminal / Command Line `cd` into this directory (where the `bitrise.yml` of the step is located)
1. Run: `bitrise run test` to test the step
1. Run: `bitrise run audit-this-step` to audit the `step.yml`
1. Check the `share-this-step` workflow in the `bitrise.yml`, and fill out the
   `envs` if you haven't done so already (don't forget to bump the version number if this is an update
   of your step!)
1. Then run: `bitrise run share-this-step` to share the step (version) you specified in the `envs`
1. Send the Pull Request, as described in the logs of `bitrise run share-this-step`

That's all ;)

## License

bitrise-step-autify-upload © [Autify Engineers](https://github.com/autifyhq). Released under the [MIT License](LICENSE).<br/>
Authored and maintained by [Autify Engineers](https://github.com/autifyhq) with help from contributors
