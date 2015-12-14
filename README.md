# Chef FreeBSD Users Cookbook

A simple cookbook for adding users to a FreeBSD node. 

## Users

Users are added from a
data bag directory. Users settings are configured in a json file in the
data bags directory; the name of the data bag directory is set in the 
attributes for this cookbook. The default data
bags directory is *users*. A simple example foobar user is shown below. This
file would be located at `data_bags/users/foobar.json`.

    {
      "id": "foobar",
      "groups": ["wheel"],
      "shell": "/usr/local/bin/bash",
      "comment": "",
      "home": "/home/foobar",
      "password": "KLNASD0(*hIHD",
      "ssh_keys": [
        "abcdefghijklm",
        "nopqrstuvwxyz" 
      ]
    }

The user foobar above will be put in the "wheel" group, have bash as the
default shell, and have a home directory created at `/home/foobar`.
Additionally, a hashed password is set, and two ssh public keys are added.
