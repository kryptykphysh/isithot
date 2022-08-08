# IsItHot POC

Could I have done more on this? Certainly. However, I'd intended to do the majority or the work on ferry back from NI, and the internet on board was awful.

Enough excuses. What *have* I done?

When I was talking to Salla before, she was mentioning that there'd been work on Dockerising and sorting out your deployment pipelines. With that in mind, I probably spent most of my time working on those areas. The instructions for locally working on the app and deploying to AWS are both below. A working example of the application is deployed at [isithot.kryptykphysh.uk](https://isithot.kryptykphysh.uk).

It is far from perfect.

## Running Locally

Assuming you have the latest version of [Docker](https://www.docker.com/products/docker-desktop/) installed, you should be able to get the application running by following the steps below:

1. In the application directory run: `docker compose run --rm web ./bin/rails db:setup`. This will write the only model table `temperature_definitions` to the database.
2. Run `docker compose up` With the optional `-d` flag, if you want to run it daemonised and not be spammed with logs.
3. Profit! Or, better yet, visit `http://localhost:3000` in your browser and have fun.

Other containers run are:
- css: This automatically recompiles css on changes. I'm using DaisyUI, which requires the full TailwindCSS CLI, so this is beyond the scope of the normal `./bin/dev` Procfile.
- guard: This will automatically run tests on code changes.

I normally also run a redis container and a set of worker containers for processing background jobs, but this was outside the scope of the build.

Since the code directory is a [bind mount](https://docs.docker.com/storage/bind-mounts/), the containers reflect live code changes.

Development secrets are in the encrypted `config/credentials/development.yml.enc` and I've kept the key file in there, as there is no sensitive information in there that's in the live environment.

That's all there is to it, really. I've probably missed *something*, though, so please let me know what it is.

## Deployment

I'm using [AWS Copilot](https://aws.github.io/copilot-cli/) to deploy the stack to AWS. Assuming you have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed and configured, and Copilot installed, the deployment steps are:

1. Only required the first time, run: `copilot deploy -e prod`. Follow the prompts and then do `copilot secret init` and create the RAILS_MASTER_KEY to decrypt production secrets.
2. `copilot svc deploy -e prod -n web` We only have one service to deploy here, and it has the database as an addon. After that, it's all done.

## TODO

1. More tests! I know I should have more tests, but I wanted to get the app out there.
2. Not sure I like having the Temperature Definition form on the same page as the search. I'd definitely want to abstract that away when I did auth so only registered users could change temperature definitions.
3. Sort out some of the CSS. TailwindCSS/DaisyUI does a lot for you, but having form elements realign when a TurboStream updates is suboptimal.
4. Maybe keep the forms on the same page, but hook them together with a Stimulus controller so you don't have to create a new Temperature Definition instance to get different weather results.
5. Better error messaging on API failures. It's... ok at present.
