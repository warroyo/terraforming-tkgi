# terraforming-tkgi


## Building the docker image

the dockerfile in this repo will create an image with the required tools to run these modules. this is how you build it, you can also use a pre-built image at `warroyo90/terraforming-tkgi:1.0.0`

1. copy the pivnet token template

```
cp pivnet_token.template pivnet_token.txt
```

2. go to network.pivotal.io , sign in
3. in the top right go to the dropdown and "edit profile" click generate refresh token. 
4. paste the refresh token into the new file.
5. build the image

```
./build.sh
```