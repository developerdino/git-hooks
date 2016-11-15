# Git hooks collection for PHP projects

# Installation

```
composer require mofodojodino/git-hooks
```

Then add this scripts section to your project composer.json to run the `install_hooks.sh` whenever an update or install occurs.

composer.json
```
{
    ...
    "scripts": {
        "post-install-cmd": [
            "bash ./vendor/mofodojodino/git-hooks/install_hooks.sh --quiet"
        ],
        "post-update-cmd": [
            "bash ./vendor/mofodojodino/git-hooks/install_hooks.sh --quiet"
        ]
    }
}
```

And that's it, every time you run `composer install` or `composer update` your git hooks will then be updated to the latest.  
