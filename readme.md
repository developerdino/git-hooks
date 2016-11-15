# Git hooks collection for PHP projects

# Installation

Add the following to your require-dev and scripts sections of your project composer.json.
Next run `composer update` to pull in the package.
 
This will run the update and automatically install the hooks in git.

composer.json
```
{
    "require-dev" {
        "mofodojodino/git-hooks": "dev-master"
    },
    "scripts": {
        "post-install-cmd": [
            "bash ./vendor/mofodojodino/git-hooks/install_hooks.sh"
        ],
        "post-update-cmd": [
            "bash ./vendor/mofodojodino/git-hooks/install_hooks.sh"
        ]
    }
}
```

And that's it, every time you run `composer install` or `composer update` your git hooks will then be updated to the latest.  
